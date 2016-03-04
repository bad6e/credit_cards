category_one   = Category.create(name: 'airline-credit-cards', slug: 'airline-credit-cards')
category_two   = Category.create(name: 'travel-credit-cards', slug: 'travel-credit-cards')
category_three = Category.create(name: 'business-rewards-credit-cards', slug: 'business-rewards-credit-cards')
category_four  = Category.create(name: 'hotel-credit-cards', slug: 'hotel-credit-cards')
category_five  = Category.create(name: 'cash-back-credit-cards', slug: 'cash-back-credit-cards')
category_six   = Category.create(name: 'other-credit-cards', slug: 'other-credit-cards')
category_seven = Category.create(name: 'best-credit-card-offers', slug: 'best-credit-card-offers')

User.create(first_name: "Bret",
            last_name: "Doucette",
            email: "doucette.bret@gmail.com",
            password: "Kt4ybbAdmin",
            role: 1)

card_one   = Card.create(name: "Southwest Airlines Rapid Rewards® Premier Credit Card",
                         annual_fee: "$99",
                         information: ["No Blackout Dates, Bags Fly Free®.", "Earn 50,000 points after you spend $2,000 on purchases."],
                         apr: "12%",
                         intro_rate: "N/A",
                         image_link: "http://media.linkoffers.com/110x70/southwest-airlines-rapid-rewards-premier-credit-card-062515.png")

c1 = Card.find(card_one.id)
c1.categories << Category.find(category_one.id)
c1.categories << Category.find(category_two.id)


Reward.create(amount: 48000,
              length_of_time: 2,
              record_date: "2016-02-18",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

Reward.create(amount: 50000,
              length_of_time: 2,
              record_date: "2016-02-11",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

Reward.create(amount: 50000,
              length_of_time: 2,
              record_date: "2016-02-04",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)


Reward.create(amount: 40000,
              length_of_time: 2,
              record_date: "2016-01-28",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

Reward.create(amount: 40000,
              length_of_time: 2,
              record_date: "2016-01-21",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

Reward.create(amount: 40000,
              length_of_time: 2,
              record_date: "2016-01-14",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

Reward.create(amount: 40000,
              length_of_time: 2,
              record_date: "2016-01-07",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)


Reward.create(amount: 40000,
              length_of_time: 2,
              record_date: "2015-12-31",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)


Reward.create(amount: 25000,
              length_of_time: 2,
              record_date: "2015-12-24",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)


Reward.create(amount: 25000,
              length_of_time: 2,
              record_date: "2015-12-17",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)


Reward.create(amount: 25000,
              length_of_time: 2,
              record_date: "2015-12-10",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

Reward.create(amount: 25000,
              length_of_time: 2,
              record_date: "2015-12-03",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

Reward.create(amount: 25000,
              length_of_time: 2,
              record_date: "2015-11-26",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)


Reward.create(amount: 25000,
              length_of_time: 2,
              record_date: "2015-11-19",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)


Reward.create(amount: 50000,
              length_of_time: 2,
              record_date: "2015-11-12",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

card_two   = Card.create(name: "TD Aeroplan™ Visa Signature® Credit Card",
                         annual_fee: "$0 Annual Intro Fee for the first year, then $95",
                         information: ["Annual fee waived for the first year, then $95 each year thereafter.", "Click here to view Terms and Conditions."],
                         apr: "14.24%-23.24% (VARIABLE)",
                         intro_rate: "N/A",
                         image_link: "http://media.linkoffers.com/110x70/td-aeroplan-visa-signature-091515.png")

c2 = Card.find(card_two.id)
c2.categories << Category.find(category_one.id)
c2.categories << Category.find(category_two.id)

card_three = Card.create(name: "Chase Sapphire Preferred® Card",
                         annual_fee: "$99",
                         information: ["Earn 50,000 bonus points when you spend $4,000 on purchases in the first 3 months from account opening.","That's $625 in travel when you redeem through Chase Ultimate Rewards®."],
                         apr: "16.24%-23.24% VARIABLE",
                         intro_rate: "N/A",
                         image_link: "http://media.linkoffers.com/110x70/chase-sapphire-preferred-091814.png")

c3 = Card.find(card_three.id)
c3.categories << Category.find(category_two.id)
c3.categories << Category.find(category_four.id)


Reward.create(amount: 50000,
              length_of_time: 2,
              record_date: "2016-02-18",
              spending_amount: 3000,
              apply_link: "https://creditcards.chase.com/a1/sapphire/apply50?",
              card_id: card_three.id)

Reward.create(amount: 50000,
              length_of_time: 2,
              record_date: "2016-02-11",
              spending_amount: 3000,
              apply_link: "https://creditcards.chase.com/a1/sapphire/apply50?",
              card_id: card_three.id)

Reward.create(amount: 50000,
              length_of_time: 2,
              record_date: "2016-02-04",
              spending_amount: 3000,
              apply_link: "https://creditcards.chase.com/a1/sapphire/apply50?",
              card_id: card_three.id)


Reward.create(amount: 50000,
              length_of_time: 2,
              record_date: "2016-01-28",
              spending_amount: 3000,
              apply_link: "https://creditcards.chase.com/a1/sapphire/apply50?",
              card_id: card_three.id)

Reward.create(amount: 50000,
              length_of_time: 2,
              record_date: "2016-01-21",
              spending_amount: 3000,
              apply_link: "https://creditcards.chase.com/a1/sapphire/apply50?",
              card_id: card_three.id)

Reward.create(amount: 50000,
              length_of_time: 2,
              record_date: "2016-01-14",
              spending_amount: 3000,
              apply_link: "https://creditcards.chase.com/a1/sapphire/apply50?",
              card_id: card_three.id)


Reward.create(amount: 50000,
              length_of_time: 2,
              record_date: "2016-01-07",
              spending_amount: 3000,
              apply_link: "https://creditcards.chase.com/a1/sapphire/apply50?",
              card_id: card_three.id)


Reward.create(amount: 50000,
              length_of_time: 2,
              record_date: "2015-12-31",
              spending_amount: 3000,
              apply_link: "https://creditcards.chase.com/a1/sapphire/apply50?",
              card_id: card_three.id)


Reward.create(amount: 50000,
              length_of_time: 2,
              record_date: "2015-12-24",
              spending_amount: 3000,
              apply_link: "https://creditcards.chase.com/a1/sapphire/apply50?",
              card_id: card_three.id)


Reward.create(amount: 50000,
              length_of_time: 2,
              record_date: "2015-12-17",
              spending_amount: 3000,
              apply_link: "https://creditcards.chase.com/a1/sapphire/apply50?",
              card_id: card_three.id)


Reward.create(amount: 50000,
              length_of_time: 2,
              record_date: "2015-12-10",
              spending_amount: 3000,
              apply_link: "https://creditcards.chase.com/a1/sapphire/apply50?",
              card_id: card_three.id)

Reward.create(amount: 40000,
              length_of_time: 2,
              record_date: "2015-12-03",
              spending_amount: 3000,
              apply_link: "https://creditcards.chase.com/a1/sapphire/apply50?",
              card_id: card_three.id)

Reward.create(amount: 40000,
              length_of_time: 2,
              record_date: "2015-11-26",
              spending_amount: 3000,
              apply_link: "https://creditcards.chase.com/a1/sapphire/apply50?",
              card_id: card_three.id)


Reward.create(amount: 40000,
              length_of_time: 2,
              record_date: "2015-11-19",
              spending_amount: 3000,
              apply_link: "https://creditcards.chase.com/a1/sapphire/apply50?",
              card_id: card_three.id)


Reward.create(amount: 40000,
              length_of_time: 2,
              record_date: "2015-11-12",
              spending_amount: 3000,
              apply_link: "https://creditcards.chase.com/a1/sapphire/apply50?",
              card_id: card_three.id)



card_four  = Card.create(name: "Denver Broncos Extra Points Credit Card",
                         annual_fee: "$99",
                         information: ["Earn 10,000 bonus points after $500 in purchases in the first 90 days, enough to redeem for $100 cash back", "This card is bad."],
                         apr: "12%",
                         intro_rate: "N/A",
                         image_link: "http://media.linkoffers.com/110x70/denver-broncos-extra-points-082015.png")

c4 = Card.find(card_four.id)
c4.categories << Category.find(category_six.id)

card_five  = Card.create(name: "Starwood Preferred Guest® Credit Card from American Express",
                         annual_fee: "$0 Annual Intro Fee for the first year, then $95",
                         information: ["Booking requirements apply.", "Earn free nights at over 1,200 hotels and resorts in nearly 100 countries with no blackout dates."],
                         apr: "12%",
                         intro_rate: "N/A",
                         image_link: "http://media.linkoffers.com/110x70/starwood-preferred-guest-consumer-081115.png")

c5 = Card.find(card_five.id)
c5.categories << Category.find(category_two.id)
c5.categories << Category.find(category_four.id)


Reward.create(amount: 25000,
              length_of_time: 3,
              record_date: "2016-02-18",
              spending_amount: 3000,
              apply_link: "https://www.americanexpress.com/us/credit-cards/starwood-preferred-guest/?",
              card_id: card_five.id)

Reward.create(amount: 25000,
              length_of_time: 3,
              record_date: "2016-02-11",
              spending_amount: 3000,
              apply_link: "https://www.americanexpress.com/us/credit-cards/starwood-preferred-guest/?",
              card_id: card_five.id)

Reward.create(amount: 25000,
              length_of_time: 3,
              record_date: "2016-02-04",
              spending_amount: 3000,
              apply_link: "https://www.americanexpress.com/us/credit-cards/starwood-preferred-guest/?",
              card_id: card_five.id)


Reward.create(amount: 25000,
              length_of_time: 3,
              record_date: "2016-01-28",
              spending_amount: 3000,
              apply_link: "https://www.americanexpress.com/us/credit-cards/starwood-preferred-guest/?",
              card_id: card_five.id)

Reward.create(amount: 25000,
              length_of_time: 3,
              record_date: "2016-01-21",
              spending_amount: 3000,
              apply_link: "https://www.americanexpress.com/us/credit-cards/starwood-preferred-guest/?",
              card_id: card_five.id)

Reward.create(amount: 25000,
              length_of_time: 3,
              record_date: "2016-01-14",
              spending_amount: 3000,
              apply_link: "https://www.americanexpress.com/us/credit-cards/starwood-preferred-guest/?",
              card_id: card_five.id)


Reward.create(amount: 25000,
              length_of_time: 3,
              record_date: "2016-01-07",
              spending_amount: 3000,
              apply_link: "https://www.americanexpress.com/us/credit-cards/starwood-preferred-guest/?",
              card_id: card_five.id)


Reward.create(amount: 25000,
              length_of_time: 3,
              record_date: "2015-12-31",
              spending_amount: 3000,
              apply_link: "https://www.americanexpress.com/us/credit-cards/starwood-preferred-guest/?",
              card_id: card_five.id)


Reward.create(amount: 25000,
              length_of_time: 3,
              record_date: "2015-12-24",
              spending_amount: 3000,
              apply_link: "https://www.americanexpress.com/us/credit-cards/starwood-preferred-guest/?",
              card_id: card_five.id)


Reward.create(amount: 25000,
              length_of_time: 3,
              record_date: "2015-12-17",
              spending_amount: 3000,
              apply_link: "https://www.americanexpress.com/us/credit-cards/starwood-preferred-guest/?",
              card_id: card_five.id)


Reward.create(amount: 25000,
              length_of_time: 3,
              record_date: "2015-12-10",
              spending_amount: 3000,
              apply_link: "https://www.americanexpress.com/us/credit-cards/starwood-preferred-guest/?",
              card_id: card_five.id)

Reward.create(amount: 35000,
              length_of_time: 3,
              record_date: "2015-12-03",
              spending_amount: 3000,
              apply_link: "https://www.americanexpress.com/us/credit-cards/starwood-preferred-guest/?",
              card_id: card_five.id)

Reward.create(amount: 35000,
              length_of_time: 3,
              record_date: "2015-11-26",
              spending_amount: 3000,
              apply_link: "https://www.americanexpress.com/us/credit-cards/starwood-preferred-guest/?",
              card_id: card_five.id)


Reward.create(amount: 35000,
              length_of_time: 3,
              record_date: "2015-11-19",
              spending_amount: 3000,
              apply_link: "https://www.americanexpress.com/us/credit-cards/starwood-preferred-guest/?",
              card_id: card_five.id)


Reward.create(amount: 35000,
              length_of_time: 3,
              record_date: "2015-11-12",
              spending_amount: 3000,
              apply_link: "https://www.americanexpress.com/us/credit-cards/starwood-preferred-guest/?",
              card_id: card_five.id)

card_six   = Card.create(name: "Marriott Rewards® Premier Credit Card",
                         annual_fee: "$0 Annual Intro Fee for the first year, then $95",
                         information: ["Earn 80,000 Bonus Points after you spend $3,000 on purchases in the first 3 months from account opening.", "I like hotels."],
                         apr: "12%",
                         intro_rate: "N/A",
                         image_link: "http://media.linkoffers.com/110x70/5-marriotpremierlarge.png")

c6 = Card.find(card_six.id)
c6.categories << Category.find(category_two.id)
c6.categories << Category.find(category_four.id)


card_seven = Card.create(name: "Chase Freedom®",
                         annual_fee: "$99",
                         information: ["Unlimited 1% cash back on all other purchases — it's automatic.", "No annual fee."],
                         apr: "12%",
                         intro_rate: "N/A",
                         image_link: "http://media.linkoffers.com/110x70/chase-freedom-092915.png")

c7 = Card.find(card_seven.id)
c7.categories << Category.find(category_five.id)

card_eight = Card.create(name: "Barclaycard Arrival Plus™ World Elite MasterCard®",
                         annual_fee: "$99",
                         information: ["After that, a variable APR will apply, currently 16.24% or 20.24%.", "This si an awesome card!"],
                         apr: "12%",
                         intro_rate: "N/A",
                         image_link: "http://media.linkoffers.com/110x70/barclaycard-arrival-plus-081215.png")

c8 = Card.find(card_eight.id)
c8.categories << Category.find(category_two.id)


Reward.create(amount: 50000,
              length_of_time: 3,
              record_date: "2016-02-18",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_eight.id)

Reward.create(amount: 45000,
              length_of_time: 3,
              record_date: "2016-02-11",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_eight.id)

Reward.create(amount: 40000,
              length_of_time: 3,
              record_date: "2016-02-04",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_eight.id)


Reward.create(amount: 40000,
              length_of_time: 3,
              record_date: "2016-01-28",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_eight.id)

Reward.create(amount: 40000,
              length_of_time: 3,
              record_date: "2016-01-21",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_eight.id)

Reward.create(amount: 40000,
              length_of_time: 3,
              record_date: "2016-01-14",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_eight.id)


Reward.create(amount: 40000,
              length_of_time: 3,
              record_date: "2016-01-07",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_eight.id)


Reward.create(amount: 40000,
              length_of_time: 3,
              record_date: "2015-12-31",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_eight.id)


Reward.create(amount: 40000,
              length_of_time: 3,
              record_date: "2015-12-24",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_eight.id)


Reward.create(amount: 40000,
              length_of_time: 3,
              record_date: "2015-12-17",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_eight.id)


Reward.create(amount: 40000,
              length_of_time: 3,
              record_date: "2015-12-10",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_eight.id)

Reward.create(amount: 40000,
              length_of_time: 3,
              record_date: "2015-12-03",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_eight.id)

Reward.create(amount: 40000,
              length_of_time: 3,
              record_date: "2015-11-26",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_eight.id)


Reward.create(amount: 40000,
              length_of_time: 3,
              record_date: "2015-11-19",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_eight.id)


Reward.create(amount: 40000,
              length_of_time: 3,
              record_date: "2015-11-12",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_eight.id)



card_nine  = Card.create(name: "Capital One® QuicksilverOne® Cash Rewards Credit Card",
                         annual_fee: "$99",
                         information: ["After that, a variable APR will apply, currently 16.24% or 20.24%, depending on your creditworthiness.", "This is one of my favorites."],
                         apr: "12%",
                         intro_rate: "N/A",
                         image_link: "http://media.linkoffers.com/110x70/capital-one-quicksilverone-cash-rewards-credit-card-040815.png")

c9 = Card.find(card_nine.id)
c9.categories << Category.find(category_five.id)

card_ten   = Card.create(name: "Gold Delta SkyMiles® Business Credit Card from American Express",
                         annual_fee: "$99",
                         information: ["Pay no foreign transaction fees when you spend overseas.", "I like airplanes."],
                         apr: "12%",
                         intro_rate: "N/A",
                         image_link: "http://media.linkoffers.com/110x70/gold-delta-skymiles-business-021015.png")

Reward.create(amount: 45000,
              length_of_time: 3,
              record_date: "2016-02-18",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_ten.id)

Reward.create(amount: 45000,
              length_of_time: 3,
              record_date: "2016-02-11",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_ten.id)

Reward.create(amount: 40000,
              length_of_time: 3,
              record_date: "2016-02-04",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_ten.id)


Reward.create(amount: 40000,
              length_of_time: 3,
              record_date: "2016-01-28",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_ten.id)

Reward.create(amount: 40000,
              length_of_time: 3,
              record_date: "2016-01-21",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_ten.id)

Reward.create(amount: 40000,
              length_of_time: 3,
              record_date: "2016-01-14",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_ten.id)


Reward.create(amount: 40000,
              length_of_time: 3,
              record_date: "2016-01-07",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_ten.id)


Reward.create(amount: 40000,
              length_of_time: 3,
              record_date: "2015-12-31",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_ten.id)


Reward.create(amount: 40000,
              length_of_time: 3,
              record_date: "2015-12-24",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_ten.id)


Reward.create(amount: 40000,
              length_of_time: 3,
              record_date: "2015-12-17",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_ten.id)


Reward.create(amount: 40000,
              length_of_time: 3,
              record_date: "2015-12-10",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_ten.id)

Reward.create(amount: 40000,
              length_of_time: 3,
              record_date: "2015-12-03",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_ten.id)

Reward.create(amount: 40000,
              length_of_time: 3,
              record_date: "2015-11-26",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_ten.id)


Reward.create(amount: 40000,
              length_of_time: 3,
              record_date: "2015-11-19",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_ten.id)


Reward.create(amount: 40000,
              length_of_time: 3,
              record_date: "2015-11-12",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_ten.id)


c10 = Card.find(card_ten.id)
c10.categories << Category.find(category_one.id)
c10.categories << Category.find(category_three.id)

card_eleven   = Card.create(name: "Citi ThankYou® Preferred Card for College Students",
                            annual_fee: "$0",
                            information: ["Earn 2,500 bonus ThankYou® Points after spending $500 within the first 3 months of cardmembership.", "Travel with ease and enjoy global acceptance with Chip Technology."],
                            apr: "14.24% - 24.24%* (VARIABLE)",
                            intro_rate: "N/A",
                            image_link: "http://media.linkoffers.com/110x70/citi-thankyou-preferred-card-042415.png")


Reward.create(amount: 2000,
              length_of_time: 3,
              record_date: "2016-02-18",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_eleven.id)

Reward.create(amount: 2500,
              length_of_time: 3,
              record_date: "2016-02-11",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_eleven.id)

Reward.create(amount: 2500,
              length_of_time: 3,
              record_date: "2016-02-04",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_eleven.id)

Reward.create(amount: 2500,
              length_of_time: 3,
              record_date: "2016-01-28",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_eleven.id)

Reward.create(amount: 2500,
              length_of_time: 3,
              record_date: "2016-01-21",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_eleven.id)

c11 = Card.find(card_eleven.id)
c11.categories << Category.find(category_five.id)

card_twelve   = Card.create(name: "Citi Prestige® Card",
                            annual_fee: "$450",
                            information: ["$250 Air Travel Credit each year.", "Earn 3x points on Air Travel and Hotels."],
                            apr: "14.24% - 24.24%* (VARIABLE)",
                            intro_rate: "N/A",
                            image_link: "http://media.linkoffers.com/110x70/citi-prestige-card-102215.png")


Reward.create(amount: 35000,
              length_of_time: 3,
              record_date: "2016-02-18",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_twelve.id)

Reward.create(amount: 25000,
              length_of_time: 3,
              record_date: "2016-02-11",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_twelve.id)

Reward.create(amount: 25000,
              length_of_time: 3,
              record_date: "2016-02-04",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_twelve.id)

Reward.create(amount: 25000,
              length_of_time: 3,
              record_date: "2016-01-28",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_twelve.id)

Reward.create(amount: 25000,
              length_of_time: 3,
              record_date: "2016-01-21",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_twelve.id)

Reward.create(amount: 30000,
              length_of_time: 3,
              record_date: "2016-01-14",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_twelve.id)

c12 = Card.find(card_twelve.id)
c12.categories << Category.find(category_two.id)

card_thirteen   = Card.create(name: "The Blue for Business® Credit Card from American Express",
                              annual_fee: "$0",
                              information: ["Limited Time Offer: get up to 20,000 Membership Rewards® points", "Earn 3x points on Air Travel and Hotels."],
                              apr: "14.24% - 24.24%* (VARIABLE)",
                              intro_rate: "N/A",
                              image_link: "http://media.linkoffers.com/110x70/the-blue-for-business-credit-card-from-american-express-open-022715.png")

Reward.create(amount: 50000,
              length_of_time: 3,
              record_date: "2016-02-18",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_thirteen.id)

Reward.create(amount: 25000,
              length_of_time: 3,
              record_date: "2016-02-11",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_thirteen.id)

Reward.create(amount: 25000,
              length_of_time: 3,
              record_date: "2016-02-04",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_thirteen.id)

Reward.create(amount: 25000,
              length_of_time: 3,
              record_date: "2016-01-28",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_thirteen.id)

Reward.create(amount: 25000,
              length_of_time: 3,
              record_date: "2016-01-21",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_thirteen.id)

Reward.create(amount: 30000,
              length_of_time: 3,
              record_date: "2016-01-14",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_thirteen.id)

Reward.create(amount: 30000,
              length_of_time: 3,
              record_date: "2016-01-07",
              spending_amount: 3000,
              apply_link: "https://home.barclaycardus.com/cards/barclaycard-arrival-plus-world-elite-mastercard.html?",
              card_id:  card_thirteen.id)

c13 = Card.find(card_thirteen.id)
c13.categories << Category.find(category_three.id)


card_fourteen   = Card.create(name: "CitiBusiness® / AAdvantage® Platinum Select® World MasterCard®",
                              annual_fee: "$99",
                              information: ["Pay no foreign transaction fees when you spend overseas.", "I like airplanes."],
                              apr: "12%",
                              intro_rate: "N/A",
                              image_link: "http://media.linkoffers.com/110x70/citibusiness-aadvantage-platinum-select-world-mastercard-111314.png")

c14 = Card.find(card_fourteen.id)
c14.categories << Category.find(category_one.id)
c14.categories << Category.find(category_three.id)

card_fifteen   = Card.create(name: "Business Green Rewards Card from American Express OPEN",
                             annual_fee: "$99",
                             information: ["Pay no foreign transaction fees when you spend overseas.", "I like airplanes."],
                             apr: "12%",
                             intro_rate: "N/A",
                             image_link: "http://media.linkoffers.com/110x70/business-green-rewards-card-from-american-express-open-022715.png")

c15 = Card.find(card_fifteen.id)
c15.categories << Category.find(category_three.id)


card_sixteen   = Card.create(name: "Expedia®+ Voyager Card from Citi",
                             annual_fee: "$99",
                             information: ["Pay no foreign transaction fees when you spend overseas.", "I like airplanes."],
                             apr: "12%",
                             intro_rate: "N/A",
                             image_link: "http://media.linkoffers.com/110x70/expedia-voyager-card-from-citi.png")
c16 = Card.find(card_sixteen.id)
c16.categories << Category.find(category_two.id)












