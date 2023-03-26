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
@Table(name = "position")
public class Position {
    @Id
    @Column(name = "id_position", nullable = false)
    private Integer id;

    @Column(name = "position_name", nullable = false, length = 45)
    private String positionName;

}