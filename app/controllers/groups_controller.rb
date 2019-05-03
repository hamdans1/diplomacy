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

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])

    @group.name = params[:group][:name]
    @group.description = params[:group][:description]
    @group.public = params[:group][:public]

    if @group.save
      flash[:notice] = "Group was updated"
      redirect_to @group
    else
      flash.now[:alert] = "Error saving group. Please try again."
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])

    if @group.destroy
      flash[:notice] = "#{@group.name} was deleted successfully"
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error trying to delete this group."
      render :show
    end
  end

end
