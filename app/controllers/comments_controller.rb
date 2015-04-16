class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_topic

  def create
    @comment = @topic.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to topic_url(@topic)
    else
      render :template => "topics/show"
    end
  end

  def destroy
    @comment = @topic.comments.find( params[:id] )

    if @comment.can_delete_by?(current_user)
      @comment.destroy
    end

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  protected

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

end
