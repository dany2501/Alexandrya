# 02 — Requerimientos

Requerimientos funcionales (**RF**) y no funcionales (**RNF**). Cada uno es atómico, verificable y trazable a casos de prueba.

Columna **Plataforma**: `W` = Web, `A` = App Android, `B` = Ambas, `Adm` = Panel administrativo.

---

## Requerimientos funcionales

### Módulo: Landing pública

| ID | Requerimiento | Prioridad | Plataforma |
|----|---------------|-----------|------------|
| RF-001 | La landing muestra: inicio, beneficios, características, cómo funciona, materias disponibles, modalidades, testimonios y planes. | Alta | W |
| RF-002 | La landing muestra planes con precio y permite iniciar el registro/compra desde un CTA. | Alta | W |
| RF-003 | La landing incluye sección legal: aviso de privacidad, términos y condiciones y política de uso. | Alta | W |
| RF-004 | La landing incluye contacto: formulario, correo y enlaces a redes sociales. | Media | W |
| RF-005 | El envío del formulario de contacto genera una notificación al área correspondiente. | Media | W |

### Módulo: Registro y autenticación

| ID | Requerimiento | Prioridad | Plataforma |
|----|---------------|-----------|------------|
| RF-010 | El usuario se registra con correo y contraseña. | Alta | B |
| RF-011 | El sistema valida el correo mediante un enlace/código de confirmación antes de habilitar la cuenta. | Alta | B |
| RF-012 | El usuario puede recuperar su contraseña vía correo. | Alta | B |
| RF-013 | El usuario autenticado puede cambiar su contraseña. | Alta | B |
| RF-014 | Las contraseñas se almacenan con hash + salt (nunca en texto plano). | Alta | Backend |
| RF-015 | El login emite un access token (JWT) de vida corta y un refresh token. | Alta | B |
| RF-016 | El usuario puede activar/desactivar MFA opcional para su cuenta. | Media | B |
| RF-017 | El sistema aplica rate limiting a login, registro y recuperación de contraseña. | Alta | Backend |

### Módulo: Suscripción y pagos

| ID | Requerimiento | Prioridad | Plataforma |
|----|---------------|-----------|------------|
| RF-020 | El acceso al contenido requiere una suscripción activa de pago. | Alta | B |
| RF-021 | La suscripción tiene vigencia de 1 año desde la confirmación del pago. | Alta | Backend |
| RF-022 | El sistema soporta múltiples métodos de pago para México (mín. tarjeta y SPEI). | Alta | B |
| RF-023 | El pago se valida automáticamente vía webhook de la pasarela. | Alta | Backend |
| RF-024 | El sistema soporta pagos recurrentes y renovación de suscripción. | Alta | B |
| RF-025 | Al expirar la vigencia, el acceso al contenido se suspende automáticamente. | Alta | Backend |
| RF-026 | El sistema notifica por correo: suscripción próxima a vencer y suscripción vencida. | Alta | Backend |
| RF-027 | El alumno puede renovar su suscripción antes o después del vencimiento. | Alta | B |

### Módulo: Catálogo de contenido

| ID | Requerimiento | Prioridad | Plataforma |
|----|---------------|-----------|------------|
| RF-030 | El sistema soporta materias configurables; agregar una nueva no requiere cambios de código. | Alta | Adm |
| RF-031 | Cada materia organiza su contenido en módulos → temas → subtemas. | Alta | Adm |
| RF-032 | Cada tema/subtema tiene un banco de preguntas asociado. | Alta | Adm |
| RF-033 | Una pregunta soporta: enunciado, descripción, imagen opcional, video opcional, material de apoyo, explicación, tip, nivel de dificultad, categoría y tiempo estimado. | Alta | Adm |
| RF-034 | Cada pregunta tiene exactamente 4 opciones (A–D) y una respuesta correcta. | Alta | Adm |
| RF-035 | El administrador puede importar materias, temas y preguntas mediante carga masiva por Excel. | Alta | Adm |
| RF-036 | La carga masiva valida el archivo y reporta errores por fila sin abortar todo el lote. | Media | Adm |

### Módulo: Evaluaciones

| ID | Requerimiento | Prioridad | Plataforma |
|----|---------------|-----------|------------|
| RF-040 | El alumno puede realizar exámenes por tema, por módulo, por materia, generales y simuladores. | Alta | B |
| RF-041 | Las evaluaciones se configuran desde administración (preguntas, tiempo, alcance, modo de feedback). | Alta | Adm |
| RF-042 | El simulador aplica un tiempo límite y replica la estructura del examen real. | Alta | B |
| RF-043 | Al responder/finalizar, el sistema muestra retroalimentación: correcto/incorrecto y explicación. | Alta | B |
| RF-044 | El sistema registra cada intento con calificación, fecha, tiempo invertido, materia, módulo, tema y sección. | Alta | Backend |
| RF-045 | El alumno puede pausar/reanudar una evaluación según su configuración (no aplica a simuladores con tiempo). | Baja | B |

### Módulo: Progreso y métricas

| ID | Requerimiento | Prioridad | Plataforma |
|----|---------------|-----------|------------|
| RF-050 | El dashboard muestra avance general y avance por materia. | Alta | B |
| RF-051 | El dashboard identifica áreas de oportunidad, temas débiles y temas fuertes. | Alta | B |
| RF-052 | El sistema genera recomendaciones automáticas con base en el desempeño. | Media | B |
| RF-053 | El alumno puede consultar su historial completo de intentos. | Alta | B |

### Módulo: Material de apoyo

| ID | Requerimiento | Prioridad | Plataforma |
|----|---------------|-----------|------------|
| RF-060 | El material de apoyo (video, PDF, imagen, enlaces internos) se visualiza dentro de la plataforma. | Alta | B |
| RF-061 | El sistema no ofrece descarga directa del material. | Alta | B |
| RF-062 | El acceso a medios usa URLs firmadas/temporales ligadas a la sesión. | Alta | Backend |

### Módulo: Referidos

| ID | Requerimiento | Prioridad | Plataforma |
|----|---------------|-----------|------------|
| RF-070 | Cada alumno tiene un código/enlace de referido único. | Alta | B |
| RF-071 | Un alumno puede referir hasta 3 usuarios. | Alta | Backend |
| RF-072 | Los beneficios por referido (1, 2 y 3) son configurables desde administración. | Alta | Adm |
| RF-073 | El beneficio se otorga al cumplirse la condición configurada (ej.: el referido paga). | Alta | Backend |

### Módulo: Control de sesiones

| ID | Requerimiento | Prioridad | Plataforma |
|----|---------------|-----------|------------|
| RF-080 | El sistema permite una sola sesión activa por cuenta. | Alta | B |
| RF-081 | Iniciar sesión en un nuevo dispositivo cierra la sesión anterior y conserva solo la más reciente. | Alta | B |
| RF-082 | El sistema guarda historial de accesos con fecha, hora, IP, dispositivo y ubicación aproximada. | Alta | Backend |
| RF-083 | El sistema envía un correo notificando cada nuevo acceso. | Media | Backend |

### Módulo: Notificaciones

| ID | Requerimiento | Prioridad | Plataforma |
|----|---------------|-----------|------------|
| RF-090 | El sistema envía correo en: registro exitoso, inicio de sesión, cambio de contraseña, pago exitoso, suscripción próxima a vencer y suscripción vencida. | Alta | Backend |
| RF-091 | El sistema envía semanalmente un correo con reporte de avance, estadísticas y recomendaciones. | Media | Backend |

### Módulo: Panel administrativo

| ID | Requerimiento | Prioridad | Plataforma |
|----|---------------|-----------|------------|
| RF-100 | El panel administra usuarios, materias, módulos, temas, preguntas, respuestas, pagos, suscripciones, referidos y reportes. | Alta | Adm |
| RF-101 | El panel soporta roles (administrador, editor de contenido) con permisos diferenciados. | Alta | Adm |
| RF-102 | El panel genera reportes de uso, pagos y desempeño exportables. | Media | Adm |

### Módulo: Protección de contenido (anti-piratería)

| ID | Requerimiento | Prioridad | Plataforma |
|----|---------------|-----------|------------|
| RF-110 | El video y material premium se sirven con URLs temporales/tokenizadas ligadas a la sesión. | Alta | B |
| RF-111 | El contenido muestra watermark dinámico con identificador del alumno. | Media | B |
| RF-112 | La app Android aplica FLAG_SECURE en vistas de contenido para bloquear capturas/grabación. | Media | A |
| RF-113 | El sistema documenta los límites reales de la protección (ver [RN-040](../06-reglas-negocio/reglas-principales.md)). | Alta | — |

### Módulo: Anuncios

| ID | Requerimiento | Prioridad | Plataforma |
|----|---------------|-----------|------------|
| RF-120 | El equipo publica anuncios/comunicados in-app (banner, modal o centro de anuncios) con vigencia, audiencia segmentada y acuse en los críticos. Ver [RF-120](RF-120-anuncios.md). | Media | B/Adm |

---

## Requerimientos no funcionales

### Seguridad

| ID | Requerimiento |
|----|---------------|
| RNF-001 | Toda comunicación cliente–servidor usa TLS (HTTPS). |
| RNF-002 | El sistema mitiga el OWASP Top 10 (inyección, XSS, control de acceso roto, etc.). |
| RNF-003 | Hay protección contra bots en formularios públicos (registro, contacto, login). |
| RNF-004 | Los eventos sensibles (acceso, cambio de contraseña, pago, cambios de admin) quedan auditados de forma inmutable. |
| RNF-005 | Los datos personales se tratan conforme a la Ley Federal de Protección de Datos Personales (México). |
| RNF-006 | Los secretos (claves de pasarela, JWT) se gestionan fuera del código (secret manager). |

### Disponibilidad y rendimiento

| ID | Requerimiento |
|----|---------------|
| RNF-010 | Disponibilidad objetivo 24×7 con uptime mínimo de 99.9%. |
| RNF-011 | La arquitectura permite escalamiento horizontal detrás de un balanceador. |
| RNF-012 | El contenido estático y los medios se sirven vía CDN. |
| RNF-013 | Se usa caché (Redis) para datos de lectura frecuente (catálogo, sesión). |
| RNF-014 | El tiempo de respuesta P95 de la API de lectura es ≤ 400 ms bajo carga nominal. |
| RNF-015 | El portal del alumno carga vistas principales en ≤ 2.5 s (web) en conexión estándar. |

### Observabilidad

| ID | Requerimiento |
|----|---------------|
| RNF-020 | Métricas de sistema y negocio se exponen a Prometheus y se visualizan en Grafana. |
| RNF-021 | Los logs se centralizan en ELK con retención definida. |
| RNF-022 | Existen alertas sobre disponibilidad, errores y latencia. |

### Mantenibilidad y portabilidad

| ID | Requerimiento |
|----|---------------|
| RNF-030 | El catálogo (materias, módulos, temas) es data-driven; agregar materias es configuración, no código. |
| RNF-031 | La API se documenta con OpenAPI/Swagger. |
| RNF-032 | CI/CD automatiza build, pruebas y despliegue (GitHub Actions). |
| RNF-033 | El frontend web es responsivo y accesible (WCAG AA como meta). |

### Localización

| ID | Requerimiento |
|----|---------------|
| RNF-040 | Idioma español (México); moneda MXN; formatos de fecha/hora locales. |

<!-- FOOTER:ALEXANDRYA -->

---

<sub>📄 **Alexandrya** · `docs/05-requerimientos/00-catalogo-requerimientos.md` · Versión documental **v0.3.0** · Actualizado **2026-06-19** · 🏠 [Índice](../README.md) · 💬 [Mensajes del sistema](../14-mensajes-sistema/mensajes-sistema.md)</sub>
