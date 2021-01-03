<?php

session_start();

if (isset($_POST['imie']))
{
    //udana walidacja
    $ok = true;

    //IMIE
    $imie = $_POST['imie'];

    //długość
    if( strlen($imie) == 0 )
    {
        $ok = false;
        $_SESSION['e_imie'] = "Wprowadź imię";
    }

    //alfabet
    if( ctype_alpha($imie) == false )
    {
        $ok = false;
        $_SESSION['e_imie'] = "Imię powinno zawierać same litery";
    }

    //NAZWISKO
    $nazwisko = $_POST['nazwisko'];

    //długość
    if( strlen($nazwisko) == 0 )
    {
        $ok = false;
        $_SESSION['e_nazwisko'] = "Wprowadź nazwisko";
    }

    //alfabet
    if( ctype_alpha($nazwisko) == false )
    {
        $ok = false;
        $_SESSION['e_nazwisko'] = "Nazwisko powinno zawierać same litery";
    }

    //LOGIN
    $login = $_POST['login'];

    //długośc loginu
    if( (strlen($login) < 3) || (strlen($login) > 20) )
    {
        $ok = false;
        $_SESSION['e_login'] = "Nick musi posiadać od 3 do 20 znaków";
    }

    //znaki alfanumeryczne
    if ( ctype_alnum($login) == false )
    {
        $ok = false;
        $_SESSION['e_login'] = "Login może składać się tylko z liter i cyfr (bez polskich znaków)";
    }

    //HASŁO
    $haslo1 = $_POST['haslo1'];
    $haslo2 = $_POST['haslo2'];

    //dlugosc hasla
    if( (strlen($haslo1) < 8) || (strlen($haslo1) > 20) )
    {
        $ok = false;
        $_SESSION['e_haslo'] = "Hasło musi posiadać od 8 do 20 znaków";
    }

    if( $haslo1 != $haslo2 )
    {
        $ok = false;
        $_SESSION['e_haslo'] = "Podane hasła nie są identyczne";
    }

    $haslo_hash = password_hash($haslo1, PASSWORD_DEFAULT);

    //ROLA
    $rola = $_POST['rola'];

    if( !isset($_POST['rola']))
    {
        $ok = false;
        $_SESSION['e_rola'] = "Musisz wybrać rolę dla użytkownika";
    }

    //zapamietaj wprowadzone dane
    $_SESSION['fr_imie'] = $imie;
    $_SESSION['fr_nazwisko'] = $nazwisko;
    $_SESSION['fr_login'] = $login;
    $_SESSION['fr_haslo1'] = $haslo1;
    $_SESSION['fr_haslo2'] = $haslo2;
    if(isset($_POST['rola']))
    {
        $_SESSION['fr_rola'] = $rola;
    }

    //SPRAWDZANIE W BAZIE
    require_once('connect.php');
    mysqli_report(MYSQLI_REPORT_STRICT);

    try
    {
        $connection = new mysqli($host, $db_user, $db_password, $db_name);
        if($connection->connect_errno != 0)
        {
            throw new Exception(mysqli_connect_errno());
        }
        else
        {
            //sprawdzenie, czy login juz istnieje
            $result = $connection->query("SELECT id FROM uzytkownicy WHERE login = '$login'");

            if(!$result)
            {
                throw new Exception($connection->error);
            }

            $nrOfLogins = $result->num_rows;
            if($nrOfLogins > 0)
            {
                $ok = false;
                $_SESSION['e_login'] = "Isnieje już konto o takim loginie";
            }

            if ($ok == true)
            {
                //walidacja się powiodła
                $imie = strtolower($imie);
                $imie = ucfirst($imie);

                $nazwisko = strtolower($nazwisko);
                $nazwisko = ucfirst($nazwisko);

                if ($connection->query("INSERT INTO uzytkownicy VALUES(NULL, '$imie', '$nazwisko', '$login', '$haslo_hash', '$rola')"))
                {
                    $_SESSION['rejestracja'] = true;
                    $_SESSION['r_imie'] = $imie;
                    $_SESSION['r_nazwisko'] = $nazwisko;
                    $_SESSION['r_login'] = $login;
                    $_SESSION['r_haslo'] = $haslo1;
                    $_SESSION['r_rola'] = $rola;
                    header("Location: podsumowanie.php");
                }
                else
                {
                    throw new Exception($connection->error);
                }
            }

            $connection->close();
        }
    }
    catch (Exception $e)
    {
        echo '<span style="color: red;"> Błąd serwera. Przepraszamy za niedogodności i prosimy o rejestrację w innym terminie </span>';
        echo '<br />Informacja developerska: '.$e;
    }

}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Company Manager</title>
    <link href="style_inside.css" type="text/css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Arbutus&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=ABeeZee&display=swap" rel="stylesheet">
</head>

<body>

<div id="rejestracja">

    <h1> Dodawanie nowego użytkownika systemu </h1>

    <form method="post">
        <p>
            Imię:
            <input type="text" name="imie" value="<?php
            if(isset($_SESSION['fr_imie']))
            {
                echo $_SESSION['fr_imie'];
                unset($_SESSION['fr_imie']);
            }
            ?>">
        </p>

        <?php
        if(isset($_SESSION['e_imie']))
        {
            echo '<div class="error">'.$_SESSION['e_imie'].'</div>';
            unset($_SESSION['e_imie']);
        }
        ?>

        <p>
            Nazwisko:
            <input type="text" name="nazwisko" value="<?php
            if(isset($_SESSION['fr_nazwisko']))
            {
                echo $_SESSION['fr_nazwisko'];
                unset($_SESSION['fr_nazwisko']);
            }
            ?>">
        </p>

        <?php
        if(isset($_SESSION['e_nazwisko']))
        {
            echo '<div class="error">'.$_SESSION['e_nazwisko'].'</div>';
            unset($_SESSION['e_nazwisko']);
        }
        ?>

        <p>
            Login:
            <input type="text" name="login" value="<?php
            if(isset($_SESSION['fr_login']))
            {
                echo $_SESSION['fr_login'];
                unset($_SESSION['fr_login']);
            }
            ?>">
        </p>

        <?php
        if(isset($_SESSION['e_login']))
        {
            echo '<div class="error">'.$_SESSION['e_login'].'</div>';
            unset($_SESSION['e_login']);
        }
        ?>

        <p>
            Hasło:
            <input type="password" name="haslo1" value="<?php
            if(isset($_SESSION['fr_haslo1']))
            {
                echo $_SESSION['fr_haslo1'];
                unset($_SESSION['fr_haslo1']);
            }
            ?>">
        </p>

        <?php
        if(isset($_SESSION['e_haslo']))
        {
            echo '<div class="error">'.$_SESSION['e_haslo'].'</div>';
            unset($_SESSION['e_haslo']);
        }
        ?>

        <p>
            Powtórz hasło:
            <input type="password" name="haslo2" value="<?php
            if(isset($_SESSION['fr_haslo2']))
            {
                echo $_SESSION['fr_haslo2'];
                unset($_SESSION['fr_haslo2']);
            }
            ?>">
        </p>

        <p> Wybierz rolę użytkownika: </p>
        <div id="typeOfUser">
            <input type='radio' name='rola' value='1' id="admin" <?php
                if(isset($_SESSION['fr_rola']) && $_SESSION['fr_rola'] == 1)
                {
                    echo "checked";
                    unset($_SESSION['fr_rola']);
                }
                ?> />
            <label for="admin">administrator</label>
            <input type='radio' name='rola' value='2' id="pracownik" <?php
            if(isset($_SESSION['fr_rola']) && $_SESSION['fr_rola'] == 2)
            {
                echo "checked";
                unset($_SESSION['fr_rola']);
            }
            ?> />
            <label for="pracownik">pracownik</label>
            <input type='radio' name='rola' value='3' id="auditor" <?php
            if(isset($_SESSION['fr_rola']) && $_SESSION['fr_rola'] == 3)
            {
                echo "checked";
                unset($_SESSION['fr_rola']);
            }
            ?> />
            <label for="auditor">auditor</label>
        </div>

        <?php
        if(isset($_SESSION['e_rola']))
        {
            echo '<div class="error">'.$_SESSION['e_rola'].'</div>';
            unset($_SESSION['e_rola']);
        }
        ?>

        <input type="submit" value="Dodaj użytkownika">

        <a href="panel.php"> Wróć do panelu </a>

    </form>

</div>

</body>
</html>
