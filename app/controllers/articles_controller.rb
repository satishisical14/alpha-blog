class ArticlesController < ApplicationController
	before_action :set_article, only: [:edit, :update, :show, :destroy]
	before_action :require_user, except: [:show, :index]
	before_action :require_same_user, only: [:update, :edit, :destroy]
	
	def new
		@article = Article.new
	end

	def edit 
		@article = Article.find(params[:id])
	end

	def index 
		@articles = Article.paginate(page: params[:page], per_page: 2)
	end

	def create
		# render plain: params[:article].inspect
		@article = Article.new(article_params)
		@article.user = current_user
		if @article.save
			flash[:success] = "Article was succesfully created"
			redirect_to article_path(@article)
		else
			render :new
		end
	end

	def update
		@article = Article.find(params[:id])
		if @article.update(article_params)
			flash[:success] = "Article updated succesfully"
			redirect_to article_path(@article)
		else
			render :edit 
		end
	end

	def show
		@article = Article.find(params[:id])
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy
		flash[:success] = "Article succesfully deleted"
		redirect_to articles_path
	end

	private
	  def set_article
	  	@article = Article.find(params[:id])
	  end

		def article_params
			params.require(:article).permit(:title, :description)
		end

		def require_same_user
			if current_user != @user
				flash[:danger] = "Only Owner"
				redirect_to root_path
			end
		end
end