Probably don't read this code, because it's rushed and only need to work... Luckily, Elm code can be in a workable state without looking pretty. Yay Elm :raised_hands: 

This project is bootstrapped with [Create Elm App](https://github.com/halfzebra/create-elm-app).
You can find the more information [here](https://github.com/halfzebra/create-elm-app/blob/master/template/README.md).


#### How to build

 1. `elm app build`
 2. `rm -rf docs/`
 3. `mv build/ docs/`
 4. `mv docs/index.html index.html`
 5. Replace hash of `main.[hash].js` in `index.html`
 6. Prepend `/docs` to all absolute paths in `index.html`
