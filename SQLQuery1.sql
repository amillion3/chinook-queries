--#1
--  non_usa_customers.sql: Provide a query showing 
--  Customers (just their full names, customer ID and country) 
--  who are not in the US.

select 
	FullName = FirstName + ' ' + LastName, 
	CustomerId, 
	Country
from Customer
where Country != 'USA'


/************************************************/
-- #2
-- brazil_customers.sql: Provide a query only showing the Customers from Brazil.

select *
from Customer
where Country = 'Brazil'

/************************************************/
-- #3
-- brazil_customers_invoices.sql: Provide a query showing the Invoices of customers who are from Brazil. 
-- The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.

select 
	FullName = FirstName + ' ' + LastName,
	InvoiceId,
	InvoiceDate,
	BillingCountry
from Customer
	join Invoice on Customer.CustomerId = Invoice.CustomerId
where Country = 'Brazil'

/************************************************/
-- #4
-- sales_agents.sql: Provide a query showing only the Employees who are Sales Agents.

select *
from Employee
where title = 'Sales Support Agent'

/************************************************/
-- #5
-- unique_invoice_countries.sql: Provide a query showing a unique/distinct list of billing countries from the Invoice table.

select distinct BillingCountry
from Invoice

/************************************************/
-- #6
-- sales_agent_invoices.sql: Provide a query that shows the invoices associated with each sales agent. 
-- The resultant table should include the Sales Agent's full name.

select
	EmployeeFullName = Employee.FirstName + ' ' + Employee.LastName,
	CustomerFullName = Customer.FirstName + ' ' + Customer.LastName,
	Invoice.InvoiceId
from Employee
	join Customer on Employee.EmployeeId = Customer.SupportRepId
		join Invoice on Customer.SupportRepId = Invoice.CustomerId

/************************************************/
-- #7
-- invoice_totals.sql: Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.

select
	InvoiceTotal = Invoice.Total,
	CustomerFullName = Customer.FirstName + ' ' + Customer.LastName,
	CustomerCountry = Customer.Country,
	EmployeeFullName = Employee.FirstName + ' ' + Employee.LastName
from Employee
	join Customer on Employee.EmployeeId = Customer.CustomerId
		join Invoice on Customer.CustomerId = Invoice.InvoiceId

/*************************************************/
-- #8
--  total_invoices_{year}.sql: How many Invoices were there in 2009 and 2011?

select Count(*) InvoiceDate
from Invoice
where YEAR(InvoiceDate) = 2009 OR
	YEAR(InvoiceDate) = 2011
group by YEAR(InvoiceDate)

/************************************************/
-- #9
-- total_sales_{year}.sql: What are the respective total sales for each of those years?

select count(*) InvoiceDate, SUM(Total)
from Invoice
where YEAR(InvoiceDate) = 2009 OR
	YEAR(InvoiceDate) = 2011
group by YEAR(InvoiceDate)

/************************************************/
-- #10
-- invoice_37_line_item_count.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.

select count(*) 
from InvoiceLine
where InvoiceLineId = 37

/************************************************/
-- #11
-- line_items_per_invoice.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. 
-- HINT: GROUP BY

select count(*) InvoiceCount
from InvoiceLine
group by InvoiceId

/************************************************/
-- #12
-- line_item_track.sql: Provide a query that includes the purchased track name with each invoice line item.

select 
	Name, 
	InvoiceLineId
from Track
	join InvoiceLine on Track.TrackId = InvoiceLine.TrackId

/************************************************/
-- #13
-- line_item_track_artist.sql: Provide a query that includes the purchased track name AND artist name with each invoice line item.

select 
	InvoiceLineId,
	Track.Name,
	Artist.Name
from InvoiceLine
	join Track on InvoiceLine.TrackId = Track.TrackId
		join Album on Track.AlbumId = Album.AlbumId
			join Artist on Album.ArtistId = Artist.ArtistId

/************************************************/
-- #14
-- country_invoices.sql: Provide a query that shows the # of invoices per country. 
-- HINT: GROUP BY

select BillingCountry, Count(BillingCountry) as InvoiceCount
from Invoice
group by BillingCountry

/************************************************/
-- #15
-- playlists_track_count.sql: Provide a query that shows the total number of tracks in each playlist. 
--  The Playlist name should be include on the resulant table.

select Count(Playlist.PlaylistId), Playlist.Name
from Playlist
	join PlaylistTrack on Playlist.PlaylistId = PlaylistTrack.PlaylistId
group by Playlist.PlaylistId, Playlist.Name


/************************************************/
-- #16
-- tracks_no_id.sql: Provide a query that shows all the Tracks, but displays no IDs. 
--  The result should include the Album name, Media type and Genre.

select Track.Name, Album.Title, MediaType.Name, Genre.Name
from Track
	join Album on Track.AlbumId = Album.AlbumId
	join MediaType on Track.MediaTypeId = MediaType.MediaTypeId
	join Genre on Track.GenreId = Genre.GenreId

/************************************************/
-- #17
-- invoices_line_item_count.sql: Provide a query that shows all Invoices but includes the # of invoice line items.

select *
from Invoice
	join InvoiceLine on Invoice.InvoiceId = InvoiceLine.InvoiceId

/************************************************/
-- #18
-- sales_agent_total_sales.sql: Provide a query that shows total sales made by each sales agent.

select MAX(Employee.LastName), SUM(Invoice.Total)
from Employee
	join Customer on Employee.EmployeeId = Customer.SupportRepId
		join Invoice on Customer.CustomerId = Invoice.CustomerId
where title = 'Sales Support Agent'
group by Employee.LastName


/************************************************/
-- #19
-- top_2009_agent.sql: Which sales agent made the most in sales in 2009?
-- Hint: Use the MAX function on a subquery.

select top 1 MAX(Employee.LastName), SUM(Invoice.Total) as i
from Employee
	join Customer on Employee.EmployeeId = Customer.SupportRepId
		join Invoice on Customer.CustomerId = Invoice.CustomerId
where title = 'Sales Support Agent' and YEAR(InvoiceDate) = 2009
group by Employee.LastName
order by i desc

/************************************************/
-- #20
-- top_agent.sql: Which sales agent made the most in sales over all?

select top 1 MAX(Employee.LastName), SUM(Invoice.Total) as i
from Employee
	join Customer on Employee.EmployeeId = Customer.SupportRepId
		join Invoice on Customer.CustomerId = Invoice.CustomerId
where title = 'Sales Support Agent'
group by Employee.LastName
order by i desc

/************************************************/
-- #21
-- sales_agent_customer_count.sql: Provide a query that shows the count of customers assigned to each sales agent.

-- why does this fail without max(...) ?
select count(Customer.SupportRepId), max(Employee.LastName)
from Customer
	join Employee on Customer.SupportRepId = Employee.EmployeeId
where Title = 'Sales Support Agent'
group by Employee.EmployeeId

/************************************************/
-- #22
-- sales_per_country.sql: Provide a query that shows the total sales per country.

select sum(Total) as 'Total', BillingCountry
from Invoice
group by BillingCountry

/************************************************/
-- #23
-- top_country.sql: Which country's customers spent the most?

/************************************************/
-- #24
-- top_2013_track.sql: Provide a query that shows the most purchased track of 2013.

/************************************************/
-- #25
-- top_5_tracks.sql: Provide a query that shows the top 5 most purchased songs.

/************************************************/
-- #26
-- top_3_artists.sql: Provide a query that shows the top 3 best selling artists.

/************************************************/
-- #27
-- top_media_type.sql: Provide a query that shows the most purchased Media Type.