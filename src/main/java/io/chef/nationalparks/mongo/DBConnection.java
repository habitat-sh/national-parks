package io.chef.nationalparks.mongo;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoDatabase;

public class DBConnection
{

    private MongoDatabase mongoDB;
    private static DBConnection instance = null;

    public static synchronized MongoDatabase getDB()
    {
        if (instance == null)
        {
            instance = new DBConnection();
        }
        return instance.mongoDB;
    }

    private DBConnection()
    {
        String mongoHost = System.getProperty("MONGODB_SERVICE_HOST");
        if (mongoHost == null)
        {
            mongoHost = "127.0.0.1";
        }

        String mongoPort = System.getProperty("MONGODB_SERVICE_PORT");
        if (mongoPort == null)
        {
            mongoPort = "27017";
        }

        String mongoDBName = System.getProperty("MONGODB_DATABASE");
        if (mongoDBName == null)
        {
            mongoDBName = "demo";
        }

        System.out.printf("Attempting connection to database at mongodb://%s:%s/%s", mongoHost, mongoPort, mongoDBName);

        int port = Integer.decode(mongoPort);

        MongoClient mongo = new MongoClient(mongoHost, port);
        System.out.println("Connected to database");

        mongoDB = mongo.getDatabase(mongoDBName);
    }
}
