require 'rails_admin/abstract_model'

module RailsAdmin
  class ModelNotFound < ::StandardError
  end

  class ObjectNotFound < ::StandardError
  end

  class ApplicationController < ::ApplicationController
    newrelic_ignore if defined?(NewRelic)

    before_filter :_authenticate!
    before_filter :_authorize!
    before_filter :_audit!

    helper_method :_current_user, :_attr_accessible_role, :_get_plugin_name

    attr_reader :object, :model_config, :abstract_model

    def get_model

      #tkxel_dev: Invoice generation for the months whom vouchers sold  last month.
      @model_name = to_model_name(params[:model_name])
      raise RailsAdmin::ModelNotFound unless (@abstract_model = RailsAdmin::AbstractModel.new(@model_name))
      raise RailsAdmin::ModelNotFound if (@model_config = @abstract_model.config).excluded?
      @properties = @abstract_model.properties

      #tkxel_dev: Validate months input [1,2,3,4,5].1 represents the current ongoing month.

      if (params[:query].present? && params[:query].to_i > 0 && params[:query].to_i <=5)

        @months_before = params[:query].to_i - 1

      else
        @months_before = 1
      end

      #tkxel_dev: Calculate total number of days for last month whether 27,30,31 etc .
      sql = "select date_trunc('month', current_date - INTERVAL '#{@months_before} month') as start_date, date_trunc('month', current_date - INTERVAL '#{@months_before} month')+'1month'::interval-'1day'::interval as end_date;"
      @previous_month_dates = Reservation.find_by_sql(sql)
      start_date = @previous_month_dates[0][:start_date]
      end_date = @previous_month_dates[0][:end_date]
      @s = start_date
      @e = end_date
      venue_ids = Array.new
      #@reserve_venues have all data remember it.
      @reserve_venues = Reservation.where("created_at >= :start_date AND created_at <= :end_date",
                  {:start_date => start_date, :end_date => end_date})
      #tkxel_dev: Fetch venues_ids for total reservations in last month
      @reserve_venues.each_with_index do |venue, index|
            venue_ids[index] = venue.venue_id.to_i
      end

      correct_venue_id_format = ""
      #tkxel_dev: Making correct comma seprated format of venue ids for SQL like(10,11,12)etc
      venue_ids.each do |listing_id|
        correct_venue_id_format = correct_venue_id_format + listing_id.to_s + ","
      end

      if correct_venue_id_format.length > 0
        #tkxel_dev: remove Comma from the last index of the array
        correct_venue_id_format[correct_venue_id_format.length-1] = " "

        find_venue = "select name,id from venues where id IN(#{correct_venue_id_format})"
        @venue_names = Venue.find_by_sql(find_venue)
      end

    end

    def get_object
      raise RailsAdmin::ObjectNotFound unless (@object = @abstract_model.get(params[:id]))
    end

    def to_model_name(param)
      model_name = param.split("~").map(&:camelize).join("::")
    end

    private

    def _get_plugin_name
      @plugin_name_array ||= [RailsAdmin.config.main_app_name.is_a?(Proc) ? instance_eval(&RailsAdmin.config.main_app_name) : RailsAdmin.config.main_app_name].flatten
    end

    def _authenticate!
      instance_eval &RailsAdmin::Config.authenticate_with
    end

    def _authorize!
      instance_eval &RailsAdmin::Config.authorize_with
    end

    def _audit!
      instance_eval &RailsAdmin::Config.audit_with
    end

    def _current_user
      instance_eval &RailsAdmin::Config.current_user_method
    end

    alias_method :user_for_paper_trail, :_current_user

    def _attr_accessible_role
      instance_eval &RailsAdmin::Config.attr_accessible_role
    end

    rescue_from RailsAdmin::ObjectNotFound do
      flash[:error] = I18n.t('admin.flash.object_not_found', :model => @model_name, :id => params[:id])
      params[:action] = 'index'
      index
    end

    rescue_from RailsAdmin::ModelNotFound do
      flash[:error] = I18n.t('admin.flash.model_not_found', :model => @model_name)
      params[:action] = 'dashboard'
      dashboard
    end

    def not_found
      render :file => Rails.root.join('public', '404.html'), :layout => false, :status => :not_found
    end

    def rails_admin_controller?
      true
    end
  end

end
