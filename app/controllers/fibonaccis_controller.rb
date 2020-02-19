class FibonaccisController < ApplicationController
  before_action :set_fibonacci, only: [:show, :update, :destroy]

  # GET /fibonaccis
  def index
    @fibonaccis = Fibonacci.all

    render json: @fibonaccis
  end

  # GET /fibonaccis/1
  def show
    render json: @fibonacci
  end

  # POST /fibonaccis
  def create
    @fibonacci = Fibonacci.new(fibonacci_params)
    @fibonacci.input = params[:input]
    fib = Fibonacci.find_by(input: @fibonacci.input)
    if fib
      @fibonacci.list = fib.list
      render json: @fibonacci, status: :created, location: @fibonacci
    else
      @fibonacci.list = calculateFib(@fibonacci.input)
      @fibonacci.save
      if @fibonacci.save
        render json: @fibonacci, status: :created, location: @fibonacci
      else
        render json: @fibonacci.errors, status: :unprocessable_entity
      end
    end
  end

  def calculateFib(n)
      a = 0
      b = 1
      arr = []
      # Compute Fibonacci number in the desired position.
      n.times do
        temp = a
        a = b
        # Add up previous two numbers in sequence.
        b = temp + b
        arr << a
      end
      return arr
  end

  # PATCH/PUT /fibonaccis/1
  def update
    if @fibonacci.update(fibonacci_params)
      render json: @fibonacci
    else
      render json: @fibonacci.errors, status: :unprocessable_entity
    end
  end

  # DELETE /fibonaccis/1
  def destroy
    @fibonacci.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fibonacci
      @fibonacci = Fibonacci.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def fibonacci_params
      params.require(:fibonacci).permit(:input, :list => [])
    end
end
