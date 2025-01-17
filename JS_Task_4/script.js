document.addEventListener('DOMContentLoaded', () => {
    const recipes = [
      {
        name: 'Pancakes',
        ingredients: ['flour', 'milk', 'egg', 'sugar'],
        type: 'Breakfast',
      },
      {
        name: 'Grilled Chicken Salad',
        ingredients: ['chicken', 'lettuce', 'tomato', 'cucumber'],
        type: 'Lunch',
      },
      {
        name: 'Spaghetti Bolognese',
        ingredients: ['spaghetti', 'meat', 'tomato', 'onion'],
        type: 'Dinner',
      },
      {
        name: 'Omelette',
        ingredients: ['egg', 'milk', 'cheese'],
        type: 'Breakfast',
      },
    ];
  
    const ingredientInput = document.getElementById('ingredientInput');
    const searchBtn = document.getElementById('searchBtn');
    const recipeType = document.getElementById('recipeType');
    const recipeResults = document.getElementById('recipeResults');
  
    const displayRecipes = (filteredRecipes) => {
      recipeResults.innerHTML = '';
      if (filteredRecipes.length === 0) {
        recipeResults.innerHTML = '<p class="text-center text-muted">No recipes found</p>';
        return;
      }
  
      filteredRecipes.forEach((recipe) => {
        const recipeCard = document.createElement('div');
        recipeCard.className = 'col-md-4 recipe-card';
        recipeCard.innerHTML = `
          <h5>${recipe.name}</h5>
          <p><strong>Type:</strong> ${recipe.type}</p>
          <p><strong>Ingredients:</strong> ${recipe.ingredients.join(', ')}</p>
        `;
        recipeResults.appendChild(recipeCard);
      });
    };
  
    const filterRecipes = () => {
      const ingredients = ingredientInput.value.toLowerCase().split(',').map((i) => i.trim());
      const type = recipeType.value;
  
      const filteredRecipes = recipes.filter((recipe) => {
        const hasIngredients = ingredients.every((ing) => recipe.ingredients.includes(ing));
        const matchesType = type ? recipe.type === type : true;
        return hasIngredients && matchesType;
      });
  
      displayRecipes(filteredRecipes);
    };
  
    searchBtn.addEventListener('click', filterRecipes);
    ingredientInput.addEventListener('keypress', (e) => {
      if (e.key === 'Enter') filterRecipes();
    });
  });
  