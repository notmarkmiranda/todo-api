require 'rails_helper'

describe TodosController, type: :request do
  before do
    create_list(:todo, 3)
  end

  describe 'GET#index' do
    subject { get todos_path }

    it 'returns all todos in an array' do
      subject

      actual = JSON.parse(response.body)
      expect(actual).to match_array(Todo.all.map(&:as_json))
    end
  end

  describe 'GET#show' do
    let(:todo) { Todo.last }
    subject { get todo_path(todo) }

    it 'returns a single todo' do
      subject

      actual = JSON.parse(response.body)
      expect(actual).to eq(todo.as_json)
    end
  end

  describe 'POST#create' do
  subject { post todos_path, params: todo_attrs }
  
  describe 'happy path' do
      let(:todo_attrs) { attributes_for(:todo) }
      
      it 'creates a new todo' do
        expect { subject }.to change(Todo, :count).by(1)
      end

      it 'has 201 status' do
        subject
        expect(response).to have_http_status(201)
      end
    end

    describe 'sad path' do
      let(:todo_attrs) { attributes_for(:todo).except(:title) }
      
      it 'does not create a todo' do
        expect { subject }.not_to change(Todo, :count)
      end

      it 'has 422 status' do
        subject

        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT#update' do
    let(:new_title) { "new title" }
    let(:todo) { Todo.first }

    subject { put todo_path(todo), params: { title: new_title } }

    it 'updates the title for a specific todo' do
      old_title = Todo.first.title

      expect { subject }.to change { todo.reload; todo.title }
    end
  end

  describe 'DELETE#destroy_all' do
    subject { delete destroy_todos_path }

    it 'destroys all todos' do
      expect { subject }.to change(Todo, :count).by(-3)
    end

    it 'has 204 status' do
      subject

      expect(response).to have_http_status(204)
    end
  end
end