class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  respond_to :html, :js
  # GET /posts
  # GET /posts.json
  def index
    if params[:query].present?
      @posts = Post.where('title LIKE ?', "%#{params[:query]}%") 
    else
      @user = current_user
      @posts = Post.all
    end
    respond_to do |format|
    format.html 
    format.js 
  end 
    
    
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @posts = Post.all
    @post = Post.new(post_params)
    @post.user= current_user
    @post.save
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @posts = Post.all
    @post.update(post_params)      
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @posts = Post.all
    @post.destroy
  end
  def autocomplete
    @posts = Post.order(:title).where("title LIKE ?", "%#{params[:term]}%")
    respond_to do |format|
      format.html
      format.json { 
        render json: @posts.map(&:title)
      }
    end
  end

  def dropdown_sort
    if params[:sort].present?
      case
        when "title" == params[:sort]
          @posts = Post.all.order("#{params[:sort]} asc")
        when "body" == params[:sort]
          @posts = Post.all.order("#{params[:sort]} asc")
        when "created_at" == params[:sort]
          @posts = Post.all.order("#{params[:sort]} desc")
      end
    end  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
