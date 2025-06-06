package models;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NamedQueries({
        @NamedQuery(name = "getMyAttendanceForCandidate", query = "SELECT a FROM Attendance a WHERE a.user = :user AND a.candidate = :candidate"),
        @NamedQuery(name = "getAttendancesForCandidate", query = "SELECT a FROM Attendance a WHERE a.candidate = :candidate"),
        @NamedQuery(name = "getAttendancesByUser", query = "SELECT a FROM Attendance a WHERE a.user = :user")
})
@Entity
@Table(name = "attendances")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Attendance {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "candidate_id", nullable = false)
    private EventCandidate candidate;

    @Column(name = "status", nullable = false)
    private Integer status; // yes / maybe / no
}
