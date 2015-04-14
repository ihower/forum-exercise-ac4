class TopicsController < ApplicationController

  before_action :authenticate_user!, :only => [:new, :create, :destroy]

  def index
    if params[:cid]
      category = Category.find(params[:cid])
      @topics = category.topics
    else
      @topics = Topic.all
    end

    @q = @topics.ransack(params[:q])
    @topics = @q.result(distinct: true).page(params[:page])
  end

  def show
    @topic = Topic.find(params[:id])

    @comment = Comment.new
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user = current_user

    if @topic.save
      redirect_to topics_url
    else
      render :new
    end
  end

  protected

  def topic_params
    params.require(:topic).permit(:title, :content, :category_ids => [])
  end

end
