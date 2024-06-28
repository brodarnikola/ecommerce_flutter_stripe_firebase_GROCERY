# Flutter 3.0&Firebase Build a grocery app with Admin Panel

In this example, I learned, practice Flutter, Firebase, Stripe skill. Using Firebase Firestore to store collections for products, users, orders and Firebase functions to make payment even more secure.

This example uses stripe payment gateway together with firebase functions. So that all this thing, will work, few commands needs to be typed inside terminal. 
First it needs to be typed:
1) Firebase login -> the same email as in firebase project
2) Firebase init -> Follow the instruction.. If you already have firebase project, you can choose override.. No need for eslint. Click "y" or "yes" to install npm packages
3) Firebase deploy --only functions .. After that with this command you can deploy firebase functions, so that stripe payment gateway will work

You can add this code inside functions folder .. For some reason it did not want to deploy to github

"const functions = require("firebase-functions");
const stripe = require("stripe") //(""); // Add your secret key here

exports.stripePaymentIntentRequest = functions.https.onRequest(async (req, res) => {
    try {
        let customerId;

        //Gets the customer who's email id matches the one sent by the client
        const customerList = await stripe.customers.list({
            email: req.body.email,
            limit: 1
        });
                
        //Checks the if the customer exists, if not creates a new customer
        if (customerList.data.length !== 0) {
            customerId = customerList.data[0].id;
        }
        else {
            const customer = await stripe.customers.create({
                email: req.body.email
            });
            customerId = customer.data.id;
        }

        //Creates a temporary secret key linked with the customer 
        const ephemeralKey = await stripe.ephemeralKeys.create(
            { customer: customerId },
            { apiVersion: '2020-08-27' }
        );

        //Creates a new payment intent with amount passed in from the client
        const paymentIntent = await stripe.paymentIntents.create({
            amount: parseInt(req.body.amount),
            currency: 'usd',
            customer: customerId,
        })

        res.status(200).send({
            paymentIntent: paymentIntent.client_secret,
            ephemeralKey: ephemeralKey.secret,
            customer: customerId,
            success: true,
        })
        
    } catch (error) {
        res.status(404).send({ success: false, error: error.message })
    }
}); "

# Code updated to Flutter v3.7 

### Attention:

Hi @everyone , if you are you facing issues with the **Fancy Shimmer Image** Package in your Flutter projects. I've got a great solution for you! Switch to the **CachedNetworkImage** Package. It's important to note that the Fancy Shimmer Image Package is actually based on CachedNetworkImage, making this alternative a robust and reliable choice.

Here's how you can implement CachedNetworkImage in your code:

```dart
CachedNetworkImage(
  height: size.height * 0.2,
  width: size.height * 0.2,
  imageUrl: getCurrProduct.productImage,
  fit: BoxFit.contain,
  progressIndicatorBuilder: (context, url, downloadProgress) => Center(
    child: SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(value: downloadProgress.progress),
    ),
  ),
  errorWidget: (context, url, error) => Icon(Icons.error),
)
```

This snippet should help you integrate the **CachedNetworkImage** package easily into your applications. If you encounter any issues or have questions, please don't hesitate to reach out for assistance.

Happy Coding! :rocket:

 
