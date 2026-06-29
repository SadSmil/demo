import io.qameta.allure.karate.AllureKarate;
import java.io.File; // Ajoutez cet import

class ExamplesTest {

    @Test
    void testParallel() {
        // 1. Forcer la création du dossier avant le lancement
        new File("target/allure-results").mkdirs();

        Results results = Runner.path("classpath:examples")
                .hook(new AllureKarate()) // AllureKarate écrit ici
                .parallel(5);
                
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}