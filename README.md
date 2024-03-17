# Logistic-Regression-for-Targeted-Re-Marketing-Campaign
## Background
This case follows a re-marketing campaign by a leading carbonated drink brand to launch its latest soda fountain machine. The brand already reached out to its customer base consisting of 50,000 casual and fast-dining restaurants and saw lukewarm results with only ~2000 upgrading to the newer machine. After the initial disappointing results, the brand decided to reach out to its customers again (re-marketing) in order to win on-the-fence customers who did not respond to the initial wave of marketing. Due to the high cost of reaching out to customers and the low response rates that are observed in remarketing campaigns (half of the first wave), it was determined that it would not be profitable to reach out to all of the remaining customers. Hence, a targeted, profit-maximizing approach was required.

## Objective
To identify customers who have the most likelihood of responding to the second wave of marketing outreach and buying the new soda fountain machine, ensuring the campaign is profitable.

## Approach
Train a Logistic Regression model to predict response to the first wave of the marketing outreach. Adjust the model-predicted response probability for the second wave of marketing. Target customers with a response probability higher than the determined breakeven threshold and evaluate the profitability of the remarketing campaign. 

## Notes on the data
50,000 rows consisting of customer demographics and purchase history data. Column definitions are as follows: 
cust_id: Unique ID number for each customer
state: US state where the customer is located
zip: 5 digit ZIP code
speeddown: Average download internet speed in the area
speedup: Average upload internet speed in the area
last: Time (in months) since the customer’s last order for fountain machine supplies
numords: Number of orders for fountain machine supplies in the last year
dollars: Total money spent (in hundreds of dollars) on fountain machine supplies in the last 4 years
sincepurch: Time (in months) since most recent purchase of a fountain machine
refurb: Is 1 if the customer has ever purchased a refurbished fountain machine (0 otherwise)
oldmodel: Is 1 if the customer’s most recent fountain machine purchase is a
model no longer sold by the manufacturer (0 if it’s a model that is currently sold)
eightvalve: Is 1 if the customer’s most recent fountain machine purchase has 8 different valves/nozzles (0 if the machine has 6 valves/nozzles)
type: What kind of restaurant is this: fastcasual, quickservice, or other
income: Median household income (100k dollars) in ZIP code
medhvalue: Median value (100k dollars) for all owner-occupied housing units in ZIP code
buy1: Response to wave 1 offer (1 = accepted the offer, 0 = did not accept)
training: 70/30 split (1 = training sample, 0 = validation sample)


