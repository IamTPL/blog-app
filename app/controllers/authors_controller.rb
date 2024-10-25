class AuthorsController < ApplicationController
  # before_action :set_author, only: %i[show edit update destroy]
  before_action :require_login, only: %i[create edit update destroy]
  before_action :correct_author, only: %i[edit update destroy]

  # GET /authors or /authors.json
  def index
    @authors = Author.all
  end

  # GET /authors/1 or /authors/1.json
  def show
    @author = Author.find(params[:id])
    @articles = @author.articles.paginate(page: params[:page], per_page: 5)
  end

  # GET /authors/new
  def new
    @author = Author.new
  end

  # GET /authors/1/edit
  def edit
  end

  # POST /authors or /authors.json
  def create
    @author = Author.new(author_params)

    respond_to do |format|
      if @author.save
        format.html { redirect_to @author, notice: 'Author was successfully created.' }
        format.json { render :show, status: :created, location: @author }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /authors/1 or /authors/1.json
  def update
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to @author, notice: 'Author was successfully updated.' }
        format.json { render :show, status: :ok, location: @author }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authors/1 or /authors/1.json
  def destroy
    if current_user == @author
      reset_session # Xóa thông tin đăng nhập
    end
    @author.destroy

    respond_to do |format|
      format.html { redirect_to authors_path, status: :see_other, notice: 'Author was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  # def set_author
  #   @author = Author.find(params[:id])
  # end

  # Only allow a list of trusted parameters through.
  def author_params
    permitted_params = %i[name age email]
    permitted_params << :password << :password_confirmation if params[:author][:password].present?
    params.require(:author).permit(permitted_params)
  end

  def correct_author
    @author = Author.find_by(id: params[:id])
    redirect_to authors_path, alert: 'Not authorized to edit this Profile' if current_user != @author
  end

  def require_login
    return if logged_in?

    flash[:alert] = 'You must be logged in to perform that action'
    redirect_to login_path
  end
end
