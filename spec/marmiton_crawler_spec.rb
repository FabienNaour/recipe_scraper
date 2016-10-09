require 'spec_helper'

describe MarmitonCrawler do

  before(:each) do
    marmiton_url = 'http://www.marmiton.org/recettes/recette_burger-d-avocat_345742.aspx'
    @recipe = MarmitonCrawler::Recipe.new marmiton_url
  end


  it 'has a version number' do
    expect(MarmitonCrawler::VERSION).not_to be nil
  end


  it 'should create the recipe' do
    expect(@recipe).not_to be nil
  end


  it 'should not instanciante the recipe because it\'s not a marmiton.org url' do
    url = 'http://www.google.fr'
    expect{MarmitonCrawler::Recipe.new url}.to raise_error(ArgumentError)
  end


  it 'should get the right title' do
    expect(@recipe.title).to eq("Burger d'avocat")
  end


  it 'should get the right times' do
    expect(@recipe.preptime).to eq(20)
    expect(@recipe.cooktime).to eq(7)
  end


  it 'should get ingredients' do
    array_exepted = ["2 beaux avocat", "2 steaks hachés de boeuf", "2 tranches de cheddar", "quelques feuilles de salade", "1/2 oignon rouge",
"1 tomate", "graines de sésame", "1 filet d'huile d'olive", "1 pincée de sel", "1 pincée de poivre"]
    expect(@recipe.ingredients).to be_kind_of(Array)
    expect(@recipe.ingredients).to eq array_exepted
  end


  it 'should get steps' do
    expect(@recipe.steps).to be_kind_of(Array)
    expect(@recipe.steps.include?('Laver et couper la tomate en rondelles'))
  end


  it 'should get image url' do
    expect(@recipe.image).to eq "http://images.marmitoncdn.org/recipephotos/multiphoto/7b/7b4e95f5-37e0-4294-bebe-cde86c30817f_normal.jpg"
  end


  it 'should export all informations to an array' do
    exepted_hash = { :cooktime => 7,
       :image => "http://images.marmitoncdn.org/recipephotos/multiphoto/7b/7b4e95f5-37e0-4294-bebe-cde86c30817f_normal.jpg",
       :ingredients => ["2 beaux avocat", "2 steaks hachés de boeuf", "2 tranches de cheddar", "quelques feuilles de salade", "1/2 oignon rouge", "1 tomate", "graines de sésame", "1 filet d'huile d'olive", "1 pincée de sel", "1 pincée de poivre"],
       :preptime => 20,
       :steps => ["Laver et couper la tomate en rondelles", "Cuire les steaks à la poêle avec un filet d'huile d'olive", "Saler et poivrer", "Toaster les graines de sésames", "Ouvrir les avocats en 2, retirer le noyau et les éplucher", "Monter les burger en plaçant un demi-avocat face noyau vers le haut, déposer un steak, une tranche de cheddar sur le steak bien chaud pour qu'elle fonde, une rondelle de tomate, une rondelle d'oignon, quelques feuilles de salade et terminer par la seconde moitié d'avocat", "Parsemer quelques graines de sésames."],
       :title => "Burger d'avocat",
 }
    expect(@recipe.to_a).to eq exepted_hash
  end


  it 'should export all informations to json' do
    exepted_string = "{\"title\":\"Burger d'avocat\",\"preptime\":20,\"cooktime\":7,\"ingredients\":[\"2 beaux avocat\",\"2 steaks hachés de boeuf\",\"2 tranches de cheddar\",\"quelques feuilles de salade\",\"1/2 oignon rouge\",\"1 tomate\",\"graines de sésame\",\"1 filet d'huile d'olive\",\"1 pincée de sel\",\"1 pincée de poivre\"],\"steps\":[\"Laver et couper la tomate en rondelles\",\"Cuire les steaks à la poêle avec un filet d'huile d'olive\",\"Saler et poivrer\",\"Toaster les graines de sésames\",\"Ouvrir les avocats en 2, retirer le noyau et les éplucher\",\"Monter les burger en plaçant un demi-avocat face noyau vers le haut, déposer un steak, une tranche de cheddar sur le steak bien chaud pour qu'elle fonde, une rondelle de tomate, une rondelle d'oignon, quelques feuilles de salade et terminer par la seconde moitié d'avocat\",\"Parsemer quelques graines de sésames.\"],\"image\":\"http://images.marmitoncdn.org/recipephotos/multiphoto/7b/7b4e95f5-37e0-4294-bebe-cde86c30817f_normal.jpg\"}"
    expect(@recipe.to_json).to eq exepted_string
  end


end