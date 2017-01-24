# TOMProduct

- [x] Makes an HTTP call to a webservice at https://public.touchofmodern.com/ioschallenge.json
- [x] In the body of the request, send a JSON payload with today's date in it, like this: "{requestDate: 'yyyy-mm-dd'}"
- [x] If the request is correctly formatted, you'll get back a payload like this, describing a list of products (if it's not correctly formatted, you'll get an error response): { products: [ {name: 'Product A', image: 'https://photos.touchofmodern.com/blah/blah.png', price: 12.33, description: "blah blah"}, {name: 'Product B', image: 'https://photos.touchofmodern.com/blah/blah.png', price: 66.33, description: "blah blah"}, {name: 'Product C', image: 'https://photos.touchofmodern.com/blah/blah.png', price: 12.99, description: "blah blah"}, {name: 'Product D', image: 'https://photos.touchofmodern.com/blah/blah.png', price: 14.33, description: "blah blah"} ] }
- [x] Display the products nicely in a scrollable list including their name, their image, their description, and their price. Use our existing app for an idea of our asthetic.
- [x] Sorting the list of products by price
- [x] Allowing the user to swipe left and remove a product from the list, never to see it appear again
![alt tag](https://raw.githubusercontent.com/anooptomar1/)
