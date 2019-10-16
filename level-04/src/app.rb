require 'sinatra'


def get_todo
    get_todos()[@id - 1]
end

def get_todos
  @@todos ||= []
end

def update_todo(title)
    old_key=get_todos()[@id - 1].keys[0]
    get_todos()[@id-1][title] = get_todos()[@id-1].delete(old_key)
end

def delete_todo
    get_todos().slice!(@id - 1)
end

get "/todos/:id" do
    @id = params[:id].to_i
    @todo = get_todo()
    erb :todo
end

put "/todos/:id" do
    @id = params[:id].to_i
    update_todo(params[:title])
    redirect "/todos"
end

delete "/todos/:id" do
    @id = params[:id].to_i
    delete_todo()
    redirect "/todos"
end

def add_todo(todo,deadline)
  get_todos().push({todo=>deadline})
end

get "/todos" do
  @todos = get_todos()
  erb :todos
end

post "/todos" do
    add_todo(params[:title],params[:date])
    redirect "/todos"
end