class ArticlesController < ApplicationController
  # before_action :set_article, only: %i[show edit update destroy]
  before_action :require_login, only: %i[new create edit update destroy]
  before_action :correct_author, only: %i[edit update destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @authors = Author.all
    @article.build_article_detail if @article.article_detail.nil?
  end

  def new
    @article = Article.new
    @authors = Author.all
    @article_detail = @article.build_article_detail
  end

  def create
    @article = Article.new(article_params)
    @authors = Author.all

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def update
    @authors = Author.all

    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path, status: :see_other, notice: 'Article was successfully destroyed.'
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, :author_id,
                                    article_detail_attributes: %i[word_count topic published_at])
  end

  def require_login
    return if logged_in?

    flash[:alert] = 'You must be logged in to perform that action'
    redirect_to login_path
  end

  def correct_author
    @article = current_user.articles.find_by(id: params[:id])
    redirect_to articles_path, alert: 'Not authorized to edit this article' if @article.nil?
  end
end
