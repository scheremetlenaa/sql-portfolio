-- calculate the average annual revenue per Salesforce customer

SELECT ROUND(AVG(num_seats * yearly_seat_cost),2) FROM contracts;