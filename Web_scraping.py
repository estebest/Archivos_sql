
import pandas as pd
import numpy as np
import time
import random
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.chrome.options import Options

# Configurar Chrome para simular navegación real
chrome_options = Options()
chrome_options.add_argument("--start-maximized")
chrome_options.add_argument("user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/117.0.0.0 Safari/537.36")
chrome_options.add_experimental_option("excludeSwitches", ["enable-automation"])
chrome_options.add_experimental_option('useAutomationExtension', False)

driver = webdriver.Chrome(options=chrome_options)

# Leer archivo
SNIES_filtrado = pd.read_excel('primeros_links.xlsx')
links = pd.DataFrame()
links['búsqueda'] = SNIES_filtrado['búsqueda']


# Iniciar sesión en Google
driver.get("https://www.google.com")

try:
    aceptar = WebDriverWait(driver, 5).until(
        EC.element_to_be_clickable((By.XPATH, '//*[@id="L2AGLb"]/div'))
    )
    aceptar.click()
except:
    pass

primeros_links = pd.DataFrame(columns=['búsqueda', 'link'])

for i, termino in enumerate(links['búsqueda']):
    try:
        caja = driver.find_element(By.NAME, "q")
        caja.send_keys(Keys.CONTROL, 'a')
        caja.send_keys(Keys.BACKSPACE)
        caja.send_keys(termino)
        time.sleep(random.uniform(0.8, 1.6))
        caja.send_keys(Keys.ENTER)

        WebDriverWait(driver, 10).until(
            EC.visibility_of_element_located((By.CSS_SELECTOR, 'div#search'))
        )
        link = driver.find_element(By.CSS_SELECTOR, 'div#search a').get_attribute("href")
    except:
        link = None

    nuevos_datos = pd.DataFrame({'búsqueda': [termino], 'link': [link]})
    primeros_links = pd.concat([primeros_links, nuevos_datos], ignore_index=True)
    print(f"{i+1}. {termino} = {link}")

    # Tiempo de espera aleatorio para simular humano
    time.sleep(random.uniform(5, 10))

    # Pausas largas cada 20 búsquedas
    if (i+1) % 20 == 0:
        print("Pausa larga para evitar bloqueo...")
        time.sleep(random.uniform(60, 180))
        primeros_links.to_excel("links_resultado.xlsx", index=False)

    if (i+1) % 20 == 0:
        print(f"Pausa larga número {(i+1)//20}... esperando...")
        time.sleep(random.uniform(60, 180))
        print("Continuando después de la pausa larga.")

driver.quit()
primeros_links.to_excel("links_resultado.xlsx", index=False)


print(primeros_links)

