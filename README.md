# What is this? 
This is an SMS interface for finding child care centers in Somerville, MA. Its purpose is to enhance the [Somerville Early Childhood Hub](http://somervillehub.org/), a place to find resources for young children & their families in Somerville. 

Here's what the app looks like in action:

![SMS interface: "Hello! Text me an address in Somerville and I'll send you nearby early child care locations. Example: '93 Highland Ave'."](/public/sms.png)

We heard from the wonderful staff behind the Hub that they have often talked about making childcare locations available via SMS, but didn't know how to make that happen. We built this for them during [CodeAcross 2015](http://www.meetup.com/Code-for-Boston/events/219132652/).

# What inspired this? 
This app is essentially a Ruby implementation of the [Chicago Early Learning Portal](http://chicagoearlylearning.org/)'s [SMS feature](http://chicagoearlylearning.org/sms). Love to [Scott Robin](https://github.com/srobbin), [Dan O'Neil](https://github.com/danxoneil), [Derek Eder](https://github.com/derekeder/), the [contributors](https://github.com/smartchicago/chicago-early-learning/graphs/contributors), and everyone else who built Chicago's Portal. 

Looking at [mRelief](https://github.com/sariyie/mRelief), a Chicago-based SMS intake form, was very helpful in figuring out how to structure the Twilio-related code. Thank you [Genevieve Nielsen](https://github.com/genevievenielsen) and [Rose Afriyie](https://github.com/sariyie/)! 

# Where's the data from?
The initial data behind the map comes from Code for Boston, specifically the [child-care-finder-data](https://github.com/codeforboston/child-care-finder-data) & [child-care-finder](https://github.com/codeforboston/child-care-finder) repos. Code for Boston in turn got the data from the the Mass. Dept. of Early Education & Care (see codeforboston/child-care-finder#2).

# What's the tech? 
This is a Sinatra app backed by Twilio.

## Installation

Clone the directory: `git@github.com:codeforamerica/early-childhood-finder-sms.git`

Install the gems: `bundle install`

You'll need to set up a Twilio account with an SMS-enabled phone to make the app work. As of 2015 this costs $1.00/month plus ¢.75 per text sent/received. Not so bad.

Once you have the account set up, create an `env.rb` file that defines these values for your app:

```
ENV['TWILIO_SID']             = '????'
ENV['TWILIO_AUTH_TOKEN']      = '????'
ENV['TEST_TWILIO_SID']        = '????'
ENV['TEST_TWILIO_AUTH_TOKEN'] = '????'
ENV["TWILIO_PHONE"]           = '????'

```

If you want the app to respond to texts, you'll need to expose a URL on the internet. [localtunnel](http://localtunnel.me/) is a handy tool for exposing your local development machine in order to test. You will want to configure your Twilio number to the URL that localtunnel generates for this to work. 

In the medium run, you'll want to host the app on a server that doesn't shut down when you turn off your computer: see [Deploying Rack-based Apps](https://devcenter.heroku.com/articles/rack) for how to deploy a Sinatra app to Heroku.

Last and most important, there's the child care location data. This app reflects Somerville early child care locations; you will probably want yours to reflect somewhere else. Turn your data points into CareCenter objects, and the Geocoder gem will automatically attempt to geocode based on their `:address`.

The initial Somerville data from this app came from a .csv file (see `Rakefile` for import task).

# What's the status?
As of CodeAcross weekend, this SMS feature is an experiment. It painfully, desperately, achingly needs user research and testing. 

The user research might reveal that this is not a good solution at all for Somerville parents, in which case we will ditch it entirely. Such is the fate of a hackathon project:

```
Built on Saturday,
Demoed Sunday afternoon,
What does Monday hold?
```

# How can I try it out? 

As of CodeAcross weekend (Feb 21-22 2015) you can text "hello" (or any other word really) to 617-206-1937.

# Related projects

* Somerville:
  * [Somerville Child Care Map](https://github.com/alexsoble/Somerville-Child-Care-Map)
* Chicago
  * [Chicago Early Learning](https://github.com/smartchicago/chicago-early-learning/) -- specifically the text feature
* _Add more related projects right here! Yes, you!_