package io.chef.nationalparks.domain;

public class NationalPark
{
    private Object locationNumber;
    private Object locationName;
    private Object address;
    private Object city;
    private Object state;
    private Object zipCode;
    private Object phoneNumber;
    private Object faxNumber;
    private Object latitude;
    private Object longitude;
    private Object location;

    @Override
    public String toString()
    {
        return "NationalPark{" +
                "locationNumber=" + locationNumber +
                ", locationName=" + locationName +
                ", address=" + address +
                ", city=" + city +
                ", state=" + state +
                ", zipCode=" + zipCode +
                ", phoneNumber=" + phoneNumber +
                ", faxNumber=" + faxNumber +
                ", latitude=" + latitude +
                ", longitude=" + longitude +
                ", location=" + location +
                '}';
    }

    public Object getLocationNumber()
    {
        return locationNumber;
    }

    public void setLocationNumber(Object locationNumber)
    {
        this.locationNumber = locationNumber;
    }

    public Object getLocationName()
    {
        return locationName;
    }

    public void setLocationName(Object locationName)
    {
        this.locationName = locationName;
    }

    public Object getAddress()
    {
        return address;
    }

    public void setAddress(Object address)
    {
        this.address = address;
    }

    public Object getCity()
    {
        return city;
    }

    public void setCity(Object city)
    {
        this.city = city;
    }

    public Object getState()
    {
        return state;
    }

    public void setState(Object state)
    {
        this.state = state;
    }

    public Object getZipCode()
    {
        return zipCode;
    }

    public void setZipCode(Object zipCode)
    {
        this.zipCode = zipCode;
    }

    public Object getPhoneNumber()
    {
        return phoneNumber;
    }

    public void setPhoneNumber(Object phoneNumber)
    {
        this.phoneNumber = phoneNumber;
    }

    public Object getFaxNumber()
    {
        return faxNumber;
    }

    public void setFaxNumber(Object faxNumber)
    {
        this.faxNumber = faxNumber;
    }

    public Object getLatitude()
    {
        return latitude;
    }

    public void setLatitude(Object latitude)
    {
        this.latitude = latitude;
    }

    public Object getLongitude()
    {
        return longitude;
    }

    public void setLongitude(Object longitude)
    {
        this.longitude = longitude;
    }

    public Object getLocation()
    {
        return location;
    }

    public void setLocation(Object location)
    {
        this.location = location;
    }
}
