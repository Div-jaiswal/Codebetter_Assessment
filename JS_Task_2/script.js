const questions = [
    { question: "What is 2 + 2?", options: ["3", "4", "5"], answer: 1 },
    { question: "What is the capital of France?", options: ["Berlin", "Paris", "Madrid"], answer: 1 },
  ];
  
  let currentQuestion = 0;
  let score = 0;
  
  const startScreen = document.getElementById("start-screen");
  const questionScreen = document.getElementById("question-screen");
  const scoreScreen = document.getElementById("score-screen");
  
  const questionEl = document.getElementById("question");
  const optionsEl = document.getElementById("options");
  const feedbackEl = document.getElementById("feedback");
  const finalScoreEl = document.getElementById("final-score");
  
  document.getElementById("start-btn").addEventListener("click", startQuiz);
  document.getElementById("submit-btn").addEventListener("click", submitAnswer);
  document.getElementById("reset-btn").addEventListener("click", resetQuiz);
  
  function startQuiz() {
    startScreen.classList.add("d-none");
    questionScreen.classList.remove("d-none");
    loadQuestion();
  }
  
  function loadQuestion() {
    const q = questions[currentQuestion];
    questionEl.textContent = q.question;
    optionsEl.innerHTML = q.options
      .map((option, index) => `<li class="list-group-item" data-index="${index}">${option}</li>`)
      .join("");
  }
  
  optionsEl.addEventListener("click", (e) => {
    if (e.target.matches("li")) {
      document.querySelectorAll("li").forEach((li) => li.classList.remove("active"));
      e.target.classList.add("active");
    }
  });
  
  function submitAnswer() {
    const selected = document.querySelector(".active");
    if (!selected) return alert("Please select an answer!");
  
    const selectedIndex = +selected.dataset.index;
    const correctIndex = questions[currentQuestion].answer;
  
    if (selectedIndex === correctIndex) {
      feedbackEl.textContent = "Correct!";
      score++;
    } else {
      feedbackEl.textContent = "Incorrect!";
    }
  
    setTimeout(() => {
      feedbackEl.textContent = "";
      currentQuestion++;
      if (currentQuestion < questions.length) {
        loadQuestion();
      } else {
        showScore();
      }
    }, 1000);
  }
  
  function showScore() {
    questionScreen.classList.add("d-none");
    scoreScreen.classList.remove("d-none");
    finalScoreEl.textContent = `${score} / ${questions.length}`;
  }
  
  function resetQuiz() {
    currentQuestion = 0;
    score = 0;
    scoreScreen.classList.add("d-none");
    startScreen.classList.remove("d-none");
  }
  