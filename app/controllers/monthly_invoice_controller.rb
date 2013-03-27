class MonthlyInvoiceController < ApplicationController

  #tkxel_dev: PDF Report Download  for default,custom and new Layout
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
