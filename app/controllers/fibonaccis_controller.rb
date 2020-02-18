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
    filteredList = []
    if fib
      @fibonacci.list = fib.list
      # if params[:filtered] == true
      #   @fibonacci.list = FibPrime.all[0].list[0..(params[:input]-1)]
      #   # @fibonacci.list = primeFilter(@fibonacci.list)
      # end
      render json: @fibonacci, status: :created, location: @fibonacci
    else
      @fibonacci.list = fibby(@fibonacci.input)
      # if params[:filtered] == true
      #   @fibonacci.list = FibPrime.all[0].list[0..(params[:input]-1)]
      #   # @fibonacci.list = primeFilter(@fibonacci.list)
      # end
      @fibonacci.save
      if @fibonacci.save
        render json: @fibonacci, status: :created, location: @fibonacci
      else
        render json: @fibonacci.errors, status: :unprocessable_entity
      end
    end
  end

  def primeFilter(list)
    # arr = []
    # list.map { |e|
    #   if prime?(e)
    #     arr << e
    #   end
    # }
    # return arr
    arr = []
    num = @fibonacci.input
    i = 0
    mult = num * 3
    f = fibby(mult)
    # arr = eratosthenes(num*5)
    arr = []
    while arr.length < num
      fib = fibonacci(i)
      f.each do |a|
        if prime?(a)
          arr << a
        end
      end
    end
    if arr.length > num
      return arr[0...num]
    else
      return arr
    end
  end

  def eratosthenes(n)
    nums = [nil, nil, *2..n]
    (2..Math.sqrt(n)).each do |i|
      (i**2..n).step(i){|m| nums[m] = nil}  if nums[i]
    end
    nums.compact
  end

  def fibby(n)
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

      # return a
  end

  def prime?(n)
    if n == 1
      return true
    end
    if n >=2
      (2..n - 1).all? do |x|
        n % x != 0
      end
    else
      false
    end
  end

  def fibonacciSequence()
    arr = []
    num = @fibonacci.input
    while num > 0
      fib = fibonacci(num)
      arr << fib
      num -= 1
    end
    return arr.reverse
  end

  def fibonacci(n)
    return n if n <= 1
    fibonacci(n - 1) + fibonacci(n - 2)
  end

  # @fibonacci = Fibonacci.new(fibonacci_params)
  # @fibonacci.input = params[:input][:input]
  # arr = []
  # # fib = fibonacci(params[:input][:input])
  # num = params[:input][:input]
  # while num > 0
  #   fib = fibonacci(num)
  #   arr << fib
  #   num -= 1
  # end
  # @fibonacci.list = arr.reverse
  #
  # if @fibonacci.save
  #   render json: @fibonacci, status: :created, location: @fibonacci
  # else
  #   render json: @fibonacci.errors, status: :unprocessable_entity
  # end

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
