class CommentsController < ApplicationController
  before_action :set_article
  before_action :set_comment, only: %i[show edit update destroy]

  # def index
  #   @comments = @article.comments
  # end

  def create
    @comment = @article.comments.build(comment_params)

    if @comment.save
      redirect_to @article, notice: "Comment was successfully created."
    else
      flash.alert = "Comment was not created."
      render "articles/show", status: :unprocessable_entity
      # redirect_to @article
    end
  end

  def show; end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to @article, notice: "Comment updated successfully."
    else
      flash.alert = "Unable to update comment."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to @article, notice: "Comment was successfully deleted."
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_comment
    @comment = @article.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
