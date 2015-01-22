class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
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
    @post = Post.new(post_params)
    @post.user= current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
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
    logger.debug "#{params[:sort]}................."
    if params[:sort].present?
      case
        when "title" == params[:sort]
          @posts = Post.all.order("#{params[:sort]} asc")
        when "body" == params[:sort]
          @posts = Post.all.order("#{params[:sort]} asc")
        when "created_at" == params[:sort]
          @posts = Post.all.order("#{params[:sort]} desc")
     end
        logger.debug "#{@posts.inspect}............."

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
