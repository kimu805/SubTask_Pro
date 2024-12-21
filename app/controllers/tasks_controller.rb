class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, except: [ :index, :new, :create ]

  def index
    @tasks = current_user.tasks.all
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    binding.pry
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to @task, notice: "「#{@task.title}」を作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: "「#{@task.title}」を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
  end

  def destroy
    @task.destroy
    redirect_to root_path, notice: "「#{@task.title}」を削除しました"
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :deadline).merge(priority: @task.find_or_create_by(current_user, params[:task][:priority]))
  end

  def set_task
    @task = current_user.tasks.find_by(params[:id])
  end
end
