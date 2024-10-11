class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  def index
    @articles = Article.all
  end

  def show
  end

  def edit
    @authors = Author.all
  end

  def new
    @article = Article.new
    @authors = Author.all
  end

  def create
    @article = Article.new(article_params)
    @authors = Author.all

    if @article.save
      redicrect_to @article, notice: 'Article was successfully created.'
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

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, :author)
  end
end
