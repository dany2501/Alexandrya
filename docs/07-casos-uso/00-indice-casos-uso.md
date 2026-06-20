# 07 — Casos de Uso (Índice)

Catálogo de casos de uso (`CU-###`). Cada caso describe la interacción actor–sistema para lograr un objetivo, con flujo principal y referencia a sus [flujos alternos](flujos-alternos.md).

---

## 1. Índice

| ID | Caso de uso | Actor principal | Módulo | RF | Estado doc |
|----|-------------|-----------------|--------|----|-----------:|
| [CU-001](CU-001-inicio-sesion.md) | Iniciar sesión | Alumno | MOD-02 | RF-015 | ✅ Detallado |
| CU-002 | Registrarse y verificar correo | Visitante | MOD-02 | RF-010, RF-011 | 🔜 Pendiente |
| CU-003 | Recuperar contraseña | Alumno | MOD-02 | RF-012 | 🔜 Pendiente |
| CU-010 | Explorar landing y elegir plan | Visitante | MOD-01 | RF-001, RF-002 | 🔜 Pendiente |
| CU-020 | Contratar suscripción (checkout) | Alumno | MOD-03 | RF-020..023 | 🔜 Pendiente |
| CU-021 | Renovar suscripción | Alumno / Vencido | MOD-03 | RF-024, RF-027 | 🔜 Pendiente |
| CU-030 | Administrar catálogo de contenido | Editor | MOD-04 | RF-030..034 | 🔜 Pendiente |
| CU-031 | Carga masiva por Excel | Editor | MOD-04 | RF-035, RF-036 | 🔜 Pendiente |
| CU-040 | Realizar una evaluación | Alumno | MOD-05 | RF-040..044 | 🔜 Pendiente |
| CU-041 | Realizar un simulador con tiempo | Alumno | MOD-05 | RF-042 | 🔜 Pendiente |
| CU-050 | Consultar dashboard de progreso | Alumno | MOD-06 | RF-050..053 | 🔜 Pendiente |
| CU-060 | Visualizar material de apoyo | Alumno | MOD-07 | RF-060..062 | 🔜 Pendiente |
| CU-070 | Invitar referidos y obtener beneficio | Alumno | MOD-08 | RF-070..073 | 🔜 Pendiente |
| CU-080 | Recibir notificaciones | Alumno | MOD-09 | RF-090, RF-091 | 🔜 Pendiente |
| CU-090 | Operar panel administrativo | Admin | MOD-10 | RF-100..102 | 🔜 Pendiente |

---

## 2. Estructura de un caso de uso

Cada `CU-###` documenta:

1. **Identificación** — ID, nombre, actor principal, actores secundarios, módulo.
2. **Precondiciones** — qué debe cumplirse antes.
3. **Postcondiciones** — estado del sistema al terminar (éxito).
4. **Flujo principal** — pasos numerados del camino feliz.
5. **Flujos alternos** — referencias a `FA-###` (ver [flujos-alternos.md](flujos-alternos.md)).
6. **Reglas aplicables** — `RN`/`RNA` involucradas.
7. **Trazabilidad** — RF, casos de prueba, estados de pantalla.

> El primer caso ya detallado es [CU-001 — Iniciar sesión](CU-001-inicio-sesion.md), alineado con el requerimiento [RF-001A](../05-requerimientos/RF-001A-autenticacion.md).

<!-- FOOTER:ALEXANDRYA -->

---

<sub>📄 **Alexandrya** · `docs/07-casos-uso/00-indice-casos-uso.md` · Versión documental **v0.3.0** · Actualizado **2026-06-19** · 🏠 [Índice](../README.md) · 💬 [Mensajes del sistema](../14-mensajes-sistema/mensajes-sistema.md)</sub>
