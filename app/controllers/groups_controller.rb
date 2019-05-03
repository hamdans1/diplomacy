class GroupsController < ApplicationController

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new
    @group.name = params[:group][:name]
    @group.description = params[:group][:description]
    @group.public = params[:group][:public]

    if @group.save
      redirect_to @group
      flash[:notice] = "Group was successfully saved"
    else
      flash.now[:alert] = "Error trying to create this Group. Please Try Again"
      render :new
    end
  end
  
end
