package io.chef.nationalparks.rest;

import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import io.chef.nationalparks.domain.NationalPark;
import io.chef.nationalparks.mongo.DBConnection;
import org.bson.Document;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import java.util.ArrayList;
import java.util.List;

@Path("/parks")
public class NationalParksResource
{
    private MongoCollection<Document> getNationalParksCollection()
    {
        MongoDatabase db = DBConnection.getDB();
        MongoCollection<Document> parkListCollection = db.getCollection("nationalparks");

        return parkListCollection;
    }

    private NationalPark populateParkInformation(Document doc)
    {
        NationalPark np = new NationalPark();

        np.setAddress(doc.get("Address"));
        np.setCity(doc.get("City"));
        np.setFaxNumber(doc.get("Fax Number"));
        np.setLocation(doc.get("Location"));
        np.setLocationName(doc.get("Location Name"));
        np.setLocationNumber(doc.get("Location Number"));
        np.setPhoneNumber(doc.get("Phone Number"));
        np.setState(doc.get("State"));
        np.setZipCode(doc.get("Zip Code"));

        return np;
    }

    // get all the national parks
    @GET()
    @Produces("application/json")
    public List<NationalPark> getAllParks()
    {
        ArrayList<NationalPark> allParksList = new ArrayList<NationalPark>();

        MongoCollection<Document> parks = getNationalParksCollection();
        MongoCursor<Document> cursor = parks.find().iterator();

        try
        {
            while (cursor.hasNext())
            {
                allParksList.add(populateParkInformation(cursor.next()));
            }
        }
        finally
        {
            cursor.close();
        }

        return allParksList;
    }

    @GET
    @Produces("application/json")
    @Path("within")
    public List<NationalPark> findParksWithin(@QueryParam("lat1") float lat1, @QueryParam("lon1") float lon1, @QueryParam("lat2") float lat2, @QueryParam("lon2") float lon2)
    {
        ArrayList<NationalPark> allParksList = new ArrayList<NationalPark>();
        MongoCollection mlbParks = getNationalParksCollection();

        // make the query object
        BasicDBObject spatialQuery = new BasicDBObject();

        ArrayList<double[]> boxList = new ArrayList<double[]>();
        boxList.add(new double[]{new Float(lon2), new Float(lat2)});
        boxList.add(new double[]{new Float(lon1), new Float(lat1)});

        BasicDBObject boxQuery = new BasicDBObject();
        boxQuery.put("$box", boxList);

        spatialQuery.put("Location", new BasicDBObject("$geoWithin", boxQuery));
        System.out.println("Using spatial query: " + spatialQuery.toString());

        MongoCursor<Document> cursor = mlbParks.find(spatialQuery).iterator();

        try
        {
            while (cursor.hasNext())
            {
                allParksList.add(populateParkInformation(cursor.next()));
            }
        }
        finally
        {
            cursor.close();
        }

        return allParksList;
    }
}
