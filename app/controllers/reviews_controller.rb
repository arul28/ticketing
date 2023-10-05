class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]

  # GET /reviews or /reviews.json
  def index
    @users = Review.includes(:passenger).pluck(:name)
    @trains = Review.includes(:train).pluck(:train_number)
    
    @reviews = Review.includes(:passenger, :train).all
    @reviews = @reviews.where(passenger: {name: params[:name]}) if params[:name].present?
    @reviews = @reviews.where(train: {train_number: params[:train_number]}) if params[:train_number].present?
  end

  # GET /reviews/1 or /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.find_by(passenger_id: params[:passenger_id], train_id: params[:train_id])
    if @review
      redirect_to review_url(@review)
    else
      @review = Review.new
    end
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews or /reviews.json
  def create
    @review = Review.new(review_params)
    @train = Train.find(@review.train_id)
    count = Review.where(train_id: @review.train_id).count
    new_rating = @review.rating
    if count > 0
      new_rating = ((@train.rating*count) + @review.rating)/(count+1)
    end
    respond_to do |format|
      if @review.save
        if @train.update(rating: new_rating)
          format.html { redirect_to review_url(@review), notice: "Review was successfully created." }
          format.json { render :show, status: :created, location: @review }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @review.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    @train = Train.find(@review.train_id)
    count = Review.where(train_id: @review.train_id).count
    new_rating = ((count*@train.rating - @review.rating + review_params[:rating].to_i)/count)
    respond_to do |format|
      if @review.update(feedback: review_params[:feedback], rating: review_params[:rating])
        if @train.update(rating: new_rating)
          format.html { redirect_to review_url(@review), notice: "Review was successfully created." }
          format.json { render :show, status: :created, location: @review }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @review.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @train = Train.find(@review.train_id)
    count = Review.where(train_id: @review.train_id).count
    new_rating = ((count*@train.rating - @review.rating)/(count-1))
    @review.destroy
    
    respond_to do |format|
      if @train.update(rating: new_rating)
        format.html { redirect_to reviews_url, notice: "Review was successfully destroyed." }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:rating, :feedback, :train_id, :passenger_id)
    end
end
