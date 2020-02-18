class FibPrimesController < ApplicationController
  before_action :set_fib_prime, only: [:show, :update, :destroy]

  # GET /fib_primes
  def index
    @fib_primes = FibPrime.all

    render json: @fib_primes
  end

  # GET /fib_primes/1
  def show
    render json: @fib_prime
  end

  # POST /fib_primes
  def create
    @fib_prime = FibPrime.new(fib_prime_params)
    @fib_prime.list = FibPrime.all[0].list[0..(params[:input]-1)]

    render json: @fib_prime, status: :created, location: @fib_prime
    # if @fib_prime.save
    #   render json: @fib_prime, status: :created, location: @fib_prime
    # else
    #   render json: @fib_prime.errors, status: :unprocessable_entity
    # end
  end

  # PATCH/PUT /fib_primes/1
  def update
    if @fib_prime.update(fib_prime_params)
      render json: @fib_prime
    else
      render json: @fib_prime.errors, status: :unprocessable_entity
    end
  end

  # DELETE /fib_primes/1
  def destroy
    @fib_prime.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fib_prime
      @fib_prime = FibPrime.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def fib_prime_params
      params.require(:fib_prime).permit(:list)
    end
end
