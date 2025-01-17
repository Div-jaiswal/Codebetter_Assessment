document.addEventListener("DOMContentLoaded", () => {
  const articles = [];
  const articlesPerPage = 4;
  let currentPage = 1;

  const form = document.getElementById("add-article-form");
  const articlesContainer = document.getElementById("articles-container");
  const prevBtn = document.getElementById("prev-btn");
  const nextBtn = document.getElementById("next-btn");
  const pageNumbers = document.getElementById("page-numbers");

  form.addEventListener("submit", (e) => {
    e.preventDefault();
    const title = document.getElementById("title").value.trim();
    const description = document.getElementById("description").value.trim();
    const imageUrl = document.getElementById("image-url").value.trim();

    if (title && description) {
      articles.push({ title, description, imageUrl });
      form.reset();
      renderArticles();
      renderPagination();
    }
  });

  const renderArticles = () => {
    articlesContainer.innerHTML = "";
    const start = (currentPage - 1) * articlesPerPage;
    const end = start + articlesPerPage;
    const currentArticles = articles.slice(start, end);

    currentArticles.forEach(({ title, description, imageUrl }) => {
      const articleDiv = document.createElement("div");
      articleDiv.classList.add("article");
      articleDiv.innerHTML = `
        <h3>${title}</h3>
        <p>${description}</p>
        ${imageUrl ? `<img src="${imageUrl}" alt="${title}">` : ""}
      `;
      articlesContainer.appendChild(articleDiv);
    });
  };

  const renderPagination = () => {
    pageNumbers.innerHTML = "";
    const totalPages = Math.ceil(articles.length / articlesPerPage);

    for (let i = 1; i <= totalPages; i++) {
      const pageButton = document.createElement("button");
      pageButton.textContent = i;
      if (i === currentPage) pageButton.style.fontWeight = "bold";
      pageButton.addEventListener("click", () => {
        currentPage = i;
        renderArticles();
        renderPagination();
      });
      pageNumbers.appendChild(pageButton);
    }

    prevBtn.disabled = currentPage === 1;
    nextBtn.disabled = currentPage === totalPages;
  };

  prevBtn.addEventListener("click", () => {
    if (currentPage > 1) {
      currentPage--;
      renderArticles();
      renderPagination();
    }
  });

  nextBtn.addEventListener("click", () => {
    const totalPages = Math.ceil(articles.length / articlesPerPage);
    if (currentPage < totalPages) {
      currentPage++;
      renderArticles();
      renderPagination();
    }
  });
});
