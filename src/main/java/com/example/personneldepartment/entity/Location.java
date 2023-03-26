package com.example.personneldepartment.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "location")
public class Location {
    @Id
    @Column(name = "id_location", nullable = false)
    private Integer id;

    @Column(name = "country", nullable = false, length = 45)
    private String country;

    @Column(name = "city", nullable = false, length = 45)
    private String city;

    @Column(name = "local_address", nullable = false, length = 45)
    private String localAddress;


    @Column(name = "geo_link", nullable = false, length = 80)
    private String geoLink;
}