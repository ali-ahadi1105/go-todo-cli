package main

func main() {
	todos := Todos{}
	storage := NewStorage[Todos]("todos.json")
	storage.Load(&todos)
	todos.add("install nodejs")
	todos.add("check merge request")
	todos.toggle(0)
	todos.print()
	storage.Save(todos)
}
