class MonthlyInvoiceController < ApplicationController

  def monthly_invoice

    generate_invoice();

  end

  def new_layout

    generate_invoice();

  end

  def custom_invoice

    generate_invoice();


  end
end
