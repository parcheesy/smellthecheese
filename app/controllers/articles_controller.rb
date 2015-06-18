class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  def index
    @articles = Article.order(created_at: :desc)
    @current = "cheese"
  end

  # GET /articles/sports
  def sports
    @articles = Article.where(topic:"sports").order(created_at: :desc)
    @empty_message = "sports"
    @current = "sports"

    render "index"
  end

  # GET /articles/government
  def government
    @articles = Article.where(topic:"government").order(created_at: :desc)
    @empty_message = "government"
    @current = "government"

    render "index"
  end

  # GET /articles/news
  def news
    @articles = Article.where(topic:"news").order(created_at: :desc)
    @empty_message = "news"
    @current = "news"

    render "index"
  end

  # GET /articles/health
  def health
    @articles = Article.where(topic:"health").order(created_at: :desc)
    @empty_message = "health"
    @current = "health"

    render "index"
  end

  # GET /articles/programming
  def programming
    @articles = Article.where(topic:"programming").order(created_at: :desc)
    @empty_message = "programming"
    @current = "programming"

    render "index"
  end


  # GET /articles/about
  def about
    @current = "about"
    @articles = Article.where(topic:"health").order(created_at: :desc)
    @empty_message = "about"
    @current = "about"

    render "index"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :date, :body, :imagePath)
    end
end
