class TopicsController < ApplicationController

  before_action :authenticate_user!, :only => [:new, :create, :destroy]

  def about
  end

  def index
    if params[:cid] && params[:cid] != "0"
      category = Category.find(params[:cid])
      @topics = category.topics
    elsif params[:cid] == "0"
      @topics = Topic.joins("LEFT OUTER JOIN topic_categories ON topics.id = topic_categories.topic_id").group("topics.id").having("count(topic_categories.category_id) = 0")
    else
      @topics = Topic.all
    end

    @topics = @topics.only_published(current_user)

    @q = @topics.ransack(params[:q])
    @topics = @q.result(distinct: true).page(params[:page])
  end

  def show
    @topic = Topic.find(params[:id])

    unless cookies["view-topic-#{@topic.id}"]
      cookies["view-topic-#{@topic.id}"] = "true"
      @topic.view!
    end

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

  def destroy
    @topic = Topic.find( params[:id] )

    if @topic.can_delete_by?(current_user)
      @topic.destroy
    end

    redirect_to topics_url
  end

  protected

  def topic_params
    params.require(:topic).permit(:title, :content, :status, :category_ids => [])
  end

end
