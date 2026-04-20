package com.example.demo.repository;

import static org.junit.jupiter.api.Assertions.*;

import com.example.demo.domain.Employee;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.List;

public class EmployeeRepositoryImplTest {

    private EmployeeRepositoryImpl repository;

    @BeforeEach
    public void setUp() {
        repository = new EmployeeRepositoryImpl();
    }

    @Test
    public void countInicial() {
        Integer total = repository.count();
        assertEquals(3, total, "El número inicial de empleados debería ser 3.");
    }

    @Test
    public void findAllDevuelveLista() {
        List<Employee> empleados = repository.findAll();

        assertNotNull(empleados);
        assertEquals(3, empleados.size(), "Debe devolver 3 empleados.");
    }

    @Test
    public void findOneExiste() {
        Employee emp = repository.findOne(1L);

        assertNotNull(emp);
        assertEquals("Emp 1", emp.getName());
    }

    @Test
    public void findOneIdNull() {
        assertThrows(IllegalArgumentException.class,
                () -> repository.findOne(null),
                "Debe lanzar excepción si el id es null.");
    }

    @Test
    public void saveNuevoEmpleado() {
        Employee nuevo = new Employee(null, "Nuevo", 25);

        Employee guardado = repository.save(nuevo);

        assertNotNull(guardado.getId());
        assertEquals(4, repository.count(), "Debe haber 4 empleados tras guardar.");
    }

    @Test
    public void deleteEmpleadoExistente() {
        boolean eliminado = repository.delete(1L);

        assertTrue(eliminado);
        assertEquals(2, repository.count(), "Debe haber 2 empleados tras eliminar.");
    }

    @Test
    public void deleteEmpleadoNoExistente() {
        boolean eliminado = repository.delete(99L);

        assertFalse(eliminado, "No debe eliminar un empleado inexistente.");
    }
}
