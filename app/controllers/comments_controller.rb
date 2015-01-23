class CommentsController < ApplicationController
  before_action :set_comment , only: [:edit, :update, :destroy]
  before_action :load_post , only: [:new, :create]
  load_and_authorize_resource
  respond_to :js,:html
  def new
    @comment = @post.comments.build
  end

  # GET /comments/1/edit
  def edit
  end
  # POST /comments
  # POST /comments.json
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    @comment.user = current_user

     @comment.update(comment_params)
        
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @post = Post.find(params[:post_id])
      @comment = @post.comments.find(params[:id])
    end

    def load_post
      @post = Post.find(params[:post_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:title, :body,:rating, :post_id, :user_id)
    end
end
