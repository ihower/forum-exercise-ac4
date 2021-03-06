class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_topic

  def create
    @comment = @topic.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to topic_url(@topic) }
        format.js
      else
        format.html { render :template => "topics/show" }
        format.js
      end
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
