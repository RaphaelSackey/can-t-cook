from requests import Session
from pprint import pprint as pp

class Recipes:
    def __init__(self):
       self.apiurl = 'https://api.spoonacular.com/recipes/findByIngredients?ingredients' 
       self.headers ={ 
                        'Accepts' : 'application/json',
                        'x-api-key' : '967bc13ab56e4c0fba1a5a21eeb87ed7'
                    }
       self.session = Session()
       self.session.headers.update(self.headers)
    def create_url(self, ingredients): 
        url = self.apiurl + '=' 
        for i in ingredients:
            url += i + ',+' 
        url = url[:-2] + '&number=5'
        return url 
    def recipe_by_id(self, id):
        url_ = "https://api.spoonacular.com/recipes/" + str(id) +"/analyzedInstructions"
        i = self.session.get(url_)
        instruction = ""
        if len(i.json()) == 0:
            return "No recipe for the given ingredients."
        for j in (i.json()[0]['steps']):
             instruction += (j['step']) + " "
        return instruction
    def generate_instructions(self, ingredients): 
        # ingredients = ingredients.split(', ')
        # print(ingredients)
        r = self.session.get(self.create_url(ingredients))
        instructions =[
            {"title": r.json()[0]["title"],
             "image": r.json()[0]["image"],
             "recipe": self.recipe_by_id(r.json()[0]['id']) 
             },

             {
                 "title": r.json()[1]["title"],
                 "image": r.json()[1]["image"],
                 "recipe": self.recipe_by_id(r.json()[1]['id'])
             },

             {
                 "title": r.json()[2]["title"],
                 "image": r.json()[2]["image"],
                 "recipe": self.recipe_by_id(r.json()[2]['id'])
             },

              {
                 "title": r.json()[3]["title"],
                 "image": r.json()[3]["image"],
                 "recipe": self.recipe_by_id(r.json()[3]['id'])
             },

              {
                 "title": r.json()[4]["title"],
                 "image": r.json()[4]["image"],
                 "recipe": self.recipe_by_id(r.json()[4]['id'])
             }
        ]
        
        
        return instructions
    


