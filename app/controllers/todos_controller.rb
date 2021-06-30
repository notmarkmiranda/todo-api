class TodosController < ApplicationController
  def index
    render json: Todo.all
  end

  def show
    render json: Todo.find(params[:id])
  end

  def create
    todo = Todo.new(todo_params)
    if todo.save
      render json: todo, status: :created
    else
      render json: todo.errors, status: :unprocessable_entity
    end
  end

  def update
    todo = Todo.find(params[:id])
    if todo.update(todo_params)
      render json: todo
    else
      render json: todo.errors, status: :unprocessable_entity
    end
  end

  def destroy_all
    Todo.destroy_all
    head :no_content
  end

  private

  def todo_params
    params.permit(:title, :url, :ordered, :completed)
  end
end