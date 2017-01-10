class ArticlesController < ApplicationController
	before_action :authenticate_user!, except: [:show,:index] 
	before_action :set_article, except: [:index,:new,:create]
	before_action :authenticate_editor!, only: [:new,:create,:update]
	before_action :authenticate_admin!, only: [:destroy,:publish]
	def index
		@articles = Article.paginate(page: params[:page],per_page:10).publicados.ultimos
	end
	#Get /article/:id
	def show
		@article.update_visits_count
		@comment = Comment.new
	end
	def new
		@article = Article.new
		@categories = Category.all
	end

	def edit
		
	end
	#POST /articles
	def create
		@article= current_user.articles.new(article_params)
		@article.categories = (params[:categories])
		if @article.save
			redirect_to @article
		else
			render :new	
		end
	end
	def destroy
		
		@article.destroy
		redirect_to articles_path
	end

	def update
		#@article.update_attributes({title: 'Nuevo Titulo'})
		
		if @article.update(article_params)
			redirect_to @article
		else
			render :edit
		end	
	end

	def publish
		@article.publish!
		redirect_to @article
	end

	private
	def set_article
		@article = Article.find(params[:id])
	end	
	def validate_user
		redirect_to new_user_session_path, notice: "Necesitas iniciar sesión"
	end	
		def article_params
			params.require(:article).permit(:title,:body,:cover, :categories)
	end
end