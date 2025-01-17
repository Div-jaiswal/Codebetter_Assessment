document.addEventListener('DOMContentLoaded', () => {
    const taskInput = document.getElementById('taskInput');
    const addTaskBtn = document.getElementById('addTaskBtn');
    const taskList = document.getElementById('taskList');
  
    let tasks = JSON.parse(localStorage.getItem('tasks')) || [];
  
    const displayTasks = () => {
      taskList.innerHTML = '';
      tasks.forEach((task, index) => {
        const li = document.createElement('li');
        li.className = 'list-group-item d-flex justify-content-between align-items-center';
        li.innerHTML = `
          <span>${task}</span>
          <div>
            <button class="btn btn-warning btn-sm me-2" onclick="editTask(${index})">Edit</button>
            <button class="btn btn-danger btn-sm" onclick="deleteTask(${index})">Delete</button>
          </div>
        `;
        taskList.appendChild(li);
      });
    };
  
    addTaskBtn.addEventListener('click', () => {
      const task = taskInput.value.trim();
      if (task) {
        tasks.push(task);
        localStorage.setItem('tasks', JSON.stringify(tasks));
        taskInput.value = '';
        displayTasks();
      }
    });
  
    window.editTask = (index) => {
      const newTask = prompt('Edit your task:', tasks[index]);
      if (newTask) {
        tasks[index] = newTask;
        localStorage.setItem('tasks', JSON.stringify(tasks));
        displayTasks();
      }
    };
  
    window.deleteTask = (index) => {
      tasks.splice(index, 1);
      localStorage.setItem('tasks', JSON.stringify(tasks));
      displayTasks();
    };
  
    displayTasks();
  });
  