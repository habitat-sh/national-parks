package io.chef.nationalparks.rest;

import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;
import java.util.HashSet;
import java.util.Set;

@ApplicationPath("/ws")
public class JaxrsConfig extends Application
{
    private Set<Object> singletons = new HashSet<Object>();

    @Override
    public Set<Object> getSingletons()
    {
        return singletons;
    }

    public JaxrsConfig()
    {
        singletons.add(new NationalParksResource());
    }
}
