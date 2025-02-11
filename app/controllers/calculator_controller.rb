class CalculatorController < ApplicationController
  def home
    redirect_to "/square/new"
  end

  # square ------------------------------------------------------------------------
  def square_new
    render({ :template => "calculator_templates/square_new" })
  end

  def square_results
    @num = params.fetch("number").to_f
    @num_squared = @num ** 2
    render({ :template => "calculator_templates/square_results" })
  end

  # square root -------------------------------------------------------------------
  def square_root_new
    render({ :template => "calculator_templates/square_root_new" })
  end

  def square_root_results
    @num = params.fetch("number").to_f
    @num_sq_rt = @num ** 0.5
    render({ :template => "calculator_templates/square_root_results" })
  end

  # monthly payment --------------------------------------------------------------
  def payment_new
    render({ :template => "calculator_templates/payment_new" })
  end

  def payment_results
    apr = params.fetch("user_apr").to_f
    years = params.fetch("user_years").to_f
    principal = params.fetch("user_principal").to_f

    monthly_rate = apr / 100 / 12
    loan_months = years * 12

    monthly_pmt = principal * (monthly_rate * (1 + monthly_rate) ** loan_months) / (((1 + monthly_rate) ** loan_months) - 1)
    monthly_pmt = monthly_pmt.round(2)
  
    # format principal and monthly_pmt. Got this code from ChatGPT
    @formatted_principal = "$#{format('%.2f', principal).reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}"
    @formatted_monthly_pmt = "$#{format('%.2f', monthly_pmt).reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}"

    render({ :template => "calculator_templates/payment_results" })
  end

  # random number ----------------------------------------------------------------
  def random_new
    render({ :template => "calculator_templates/random_new" })
  end

  def random_results
    min = params.fetch("user_min").to_f
    max = params.fetch("user_max").to_f
    @random_number = rand(min..max)
    render({ :template => "calculator_templates/random_results" })
  end
end
