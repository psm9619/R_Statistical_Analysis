# 2-sample T test
library (dplyr)
library(ggplot2)

car_m <- mtcars %>%
  select (mpg, am)

car_auto <- subset(car_m, am ==1) ; mean(car_auto$mpg)
car_man <- subset(car_m, am == 0) 

sh1 <- shapiro.test(car_auto$mpg)  # P-v = 0.536 > 0.05, 정규성 참
sh2 <- shapiro.test(car_man$mpg)   # P-v = 0.898 > 0.05, 정규성 참
par(mfrow = c(1,2))
qqnorm(car_auto$mpg) ; qqline(car_auto$mpg)
qqnorm(car_man$mpg) ; qqline(car_man$mpg)

(v <- var.test (car_m$mpg~car_m$am)) # P-v = 0.0669 > 0.05, 등분산성 참, 두 집단 (auto, man) 의 분산이 서로 동일하다

(t <- t.test (car_m$mpg~car_m$am,
        mu = 0, var.equal = TRUE)) # P-v = 0.000 < 0.05, H_0 기각, H_a 채택

conclusion <- cat (" 정규성 검정을 통해 auto 기어 그룹의 정규성이 참 (", round(sh1$p.value,3),"> 0.05 )이며", "\n",
                   "manual 기어 그룹의 정규성 또한 참 (",round(sh2$p.value, 3), "> 0.05 ) 임을 확인하였고", "\n",
                   "등분산성 검정을 통해 p-value=", round(v$p.value,3),"이기에 두 그룹의 분산이 동일함을 확인하였다.", "\n",
                   "2-sample t-test 를 시행시, p-value =", round(t$p.value, 3),"이며 검정통계량 t =", round(t$statistic, 3),"임을 확인하여", "\n",
                   "manual 기어 자동차의 mpg 평균 (", round(t$estimate[1], 3),")과 auto 기어 자동차의 mpg 평균 (", round(t$estimate[2],3),") 의 차이는 통계적으로 유의하다 고 판단된다.")

# ------------------------------------------
mass_car <-MASS::Cars93

mass_car <- mass_car %>%
  select (Origin, Price)

(car_US <- subset(mass_car, Origin %in% "USA")) ; mean(car_US$Price)
(car_nonUS <- subset(mass_car, Origin %in% "non-USA"))

(sh1 <- shapiro.test(car_US$Price))  # P-v = 0.000 < 0.05, 정규성 거짓
(sh2 <- shapiro.test(car_US$Price))   # P-v = 0.000 < 0.05, 정규성 거짓
par(mfrow = c(1,2))
qqnorm(car_US$Price) ; qqline(car_US$Price)
qqnorm(car_nonUS$Price) ; qqline(car_nonUS$Price)

(v <- var.test (mass_car$Price~mass_car$Origin)) # P-v = 0.014 < 0.05, 등분산성 거짓, 두 집단 (auto, man) 의 분산이 서로 다르다

(t <- t.test (mass_car$Price~mass_car$Origin,
             mu = 0, var.equal = FALSE)) # P-v = 0.343 > 0.05, H_0 채택

conclusion <- cat (" 정규성 검정을 통해 USA 그룹의 정규성이 거짓 (", round(sh1$p.value,3),"< 0.05 )이며", "\n",
                   "non-USA 그룹의 정규성 또한 거짓 (",round(sh2$p.value, 3), "< 0.05 ) 임을 확인하였고", "\n",
                   "등분산성 검정을 통해 p-value=", round(v$p.value,3),"이기에 두 그룹의 분산이 동일하지 않음을 확인하였다.", "\n",
                   "2-sample t-test 를 시행시, p-value =", round(t$p.value, 3),"이며 검정통계량 t =", round(t$statistic, 3),"임을 확인하여", "\n",
                   "USA 생산 자동차의 가격 평균 (", round(t$estimate[1], 3),")과 non-USA 생산자동차의 가격 평균 (", round(t$estimate[2],3),") 은 동일하다 고 판단된다.", "\n",
                   "*일반적인 경우 위와 같이 정규성이 거짓일 때 비모수 검정을 사용해야 하나 현 과제특성상 정규성인 독립모집단의 검정법으로 진행하였다")


# --------------------------------------------------------------------------

mpg1 <- mpg %>%
  select (hwy, class) %>%
  filter(class %in% c("midsize", "subcompact"))

(mdsize <- subset(mpg1, class %in% "midsize"))  ; mean(mdsize$hwy)
(sbcmpact <- subset(mpg1, class %in% "subcompact"))

(sh1 <- shapiro.test(mdsize$hwy))  # P-v = 0.013 < 0.05, 정규성 거짓
(sh2 <- shapiro.test(sbcmpact$hwy))   # P-v = 0.010 < 0.05, 정규성 거짓
par(mfrow = c(1,2))
qqnorm(mdsize$hwy) ; qqline(mdsize$hwy)
qqnorm(sbcmpact$hwy) ; qqline(sbcmpact$hwy)

(v <- var.test (mpg1$hwy ~ mpg1$class)) # P-v = 0.000 < 0.05, 등분산성 거짓, 두 집단의 분산이 동일하지 않음

(t <- t.test (mpg1$hwy ~ mpg1$class,
             mu = 0, var.equal = FALSE)) # P-v = 0.385 > 0.05, H_0 채택

conclusion <- cat (" 정규성 검정을 통해 midsize 자동차그룹의 정규성이 거짓 (", round(sh1$p.value,3),"< 0.05 )이며", "\n",
                   "subcompact 자동차 그룹의 정규성 또한 거짓 (",round(sh2$p.value, 3), "< 0.05 ) 임을 확인하였고", "\n",
                   "등분산성 검정을 통해 p-value=", round(v$p.value,3),"이기에 두 그룹의 분산이 동일하지 않음을 확인하였다.", "\n",
                   "2-sample t-test 를 시행시, p-value =", round(t$p.value, 3),"이며 검정통계량 t =", round(t$statistic, 3),"임을 확인하여", "\n",
                   "midsize 자동차그룹의 mpg 평균 (", round(t$estimate[1], 3),")과 subcompact 자동차 그룹의 mpg 평균 (", round(t$estimate[2],3),") 은 통계적으로 동일하다 고 판단된다.", "\n",
                   "*일반적인 경우 위와 같이 정규성이 거짓일 때 비모수 검정을 사용해야 하나 현 과제특성상 정규성인 독립모집단의 검정법으로 진행하였다")

# ------------------

table(mpg$fl)

count(factor(mpg$fl))
mpg2 <- mpg %>%
  select (cty, fl) %>%
  filter(fl %in% c("p", "r"))

(p_cty <- subset(mpg2, fl %in% "p"))  ; mean(p_cty$cty)
(r_cty <- subset(mpg2, fl %in% "r"))

(sh1 <- shapiro.test(r_cty$cty))  # P-v = 0.000 < 0.05, 정규성 거짓
(sh2 <- shapiro.test(p_cty$cty))  # P-v = 0.050 = 0.05, 정규성 참  
par(mfrow = c(1,2))
qqnorm(p_cty$cty) ; qqline(p_cty$cty)
qqnorm(r_cty$cty) ; qqline(r_cty$cty)

(v <- var.test (mpg2$cty ~ mpg2$fl)) # P-v = 0.043 < 0.05, 등분산성 거짓, 두 집단의 분산이 동일하지 않음

(t <- t.test  (mpg2$cty ~ mpg2$fl,
              mu = 0, var.equal = FALSE)) # P-v = 0.228 > 0.05, H_0 채택

conclusion <- cat (" 정규성 검정을 통해 일반휘발유(r) 그룹의 정규성이 거짓 (", round(sh1$p.value,3),"< 0.05 )이며", "\n",
                   "고급휘발유(p) 그룹 의 정규성은 참 (",round(sh2$p.value, 3), "< 0.05 ) 임을 확인하였고", "\n",
                   "등분산성 검정을 통해 p-value=", round(v$p.value,3),"이기에 두 그룹의 분산이 동일하지 않음을 확인하였다.", "\n",
                   "2-sample t-test 를 시행시, p-value =", round(t$p.value, 3),"이며 검정통계량 t =", round(t$statistic, 3),"임을 확인하여", "\n",
                   "고급휘발유(p) 그룹의 cty 평균 (", round(t$estimate[1], 3),")과 일반휘발유(r) 그룹의 cty 평균 (", round(t$estimate[2],3),") 은 통계적으로 동일하다 고 판단된다.", "\n",
                   "*일반적인 경우 위와 같이 정규성이 거짓일 때 비모수 검정을 사용해야 하나 현 과제특성상 정규성인 독립모집단의 검정법으로 진행하였다")

# ----------------

mpg3 <- mpg %>%
  filter (class %in% c("subcompact")
          & drv %in% c("r", "f")) %>%
  select (cty, drv)

(f_cty <- subset(mpg3, drv %in% "f"))  ; mean(f_cty$cty)
(r_cty <- subset(mpg3, drv %in% "r"))

(sh1 <- shapiro.test(f_cty$cty))  # P-v = 0.096 > 0.05, 정규성 참
(sh2 <- shapiro.test(r_cty$cty))   # P-v = 0.105 > 0.05, 정규성 참
par(mfrow = c(1,2))
qqnorm(f_cty$cty) ; qqline(f_cty$cty)
qqnorm(r_cty$cty) ; qqline(r_cty$cty)

(v <- var.test (mpg3$cty~mpg3$drv)) # P-v = 0.003 < 0.05, 등분산성 거짓, 두 집단의 분산이 동일하지 않음

(t <- t.test (mpg3$cty~mpg3$drv,
              mu = 0, var.equal = FALSE)) # P-v = 0.000 < 0.05, H_0 채택

conclusion <- cat (" 정규성 검정을 통해 전륜구동(f)그룹의 정규성이 참 (", round(sh1$p.value,3),"< 0.05 )이며", "\n",
                   "후륜구동(r)그룹의 정규성 또한 참 (",round(sh2$p.value, 3), "< 0.05 ) 임을 확인하였고", "\n",
                   "등분산성 검정을 통해 p-value=", round(v$p.value,3),"이기에 두 그룹의 분산이 동일하지 않음을 확인하였다.", "\n",
                   "2-sample t-test 를 시행시, p-value =", round(t$p.value, 3),"이며 검정통계량 t =", round(t$statistic, 3),"임을 확인하여", "\n",
                   "전륜구동(f)그룹의 cty 평균 (", round(t$estimate[1], 3),")과 후륜구동(r)그룹의 cty 평균 (", round(t$estimate[2],3),") 은 통계적으로 차이가 있다 고 판단된다.")
                   

# ---------------------------------------------------------------------------------

placebo <- c(51.4,52.0,45.5,54.5,52.3,50.9,52.7,50.3,53.8,53.1)
med <- c(50.1,51.5,45.9,53.1,51.8,50.3,52.0,49.9,52.5,53.0)
data <- data.frame(placebo, med)
(s <-sd(data$placebo - data$med))

(t <- t.test(data$placebo, data$med, paired=T, alternative = "greater"))  # P-v = 0.003 < 0.05, H_a 채택
t$estimate

conclusion <- cat (" 위약투여 시 혈당 (Xi) 과 신약 투여시 혈당 (Yi) 를 비교 시 두 그룹의 평균 차이는", round(t$estimate, 3),"이며 표준편차는 +/- ", round(s, 3) ,"로", "\n", 
                   "1-sided Paired t-test 결과, p-value =", round(t$p.value, 3),"이며 검정통계량 t =", round(t$statistic, 3),"이기에, ", "\n",
                   "위약의 평균이 신약의 평균보다 높다, 즉 신약이 혈당 수치를 낮추는 면에 효과가 있는 것으로 판단된다.")


# ---------------------------------------------------------------------------------

A <- c(13.2,8.2,10.9,14.3,10.7,6.6,9.5,10.8,8.8,13.3) 
B <- c(14.0,8.8,11.2,14.2,11.8,6.4,9.8,11.3,9.3,13.6) 
data <- data.frame(A, B) 
(s <-sd(data$A - data$B))

(t <- t.test(data$A, data$B, paired=T))  # P-v = 0.008 < 0.05, H_a 채택
t$estimate

conclusion <- cat (" A 로 만든 신발의 닳음과 B 로 만든 신발의 닳음 정도를 비교시 두 그룹의 평균 차이는", round(t$estimate, 3),"이며 표준편차는 +/- ", round(s, 3) ,"로", "\n", 
                   "Paired t-test 결과, p-value =", round(t$p.value, 3),"이며 검정통계량 t =", round(t$statistic, 3),"이기에, ", "\n",
                   "두 재료의 재질은 차이가 있다, 즉 B 에 비해 A 의 닳음 정도가 평균적으로 더 낮은 것으로 판단된다.")


# ---------------------------------------------------------------------------------
library(reshape2)
one <- c(5, 7, 6, 8, 6, 7, 8, 8, 6, 10)
two <- c(6, 8, 9, 11, 13, 12, 10, 8, 9, 10)
three <- c(14, 25, 26, 18, 19, 22, 21, 16, 20, 30)

(data <- data.frame(lake=c(rep(1,10), rep(2,10), rep(3,10)), ppm = c(one,two,three)))

lk <- lm(ppm~lake, data=data)
ano <- anova(lk)

conclusion <- cat(" 3개 호수의 산소량 차이를 알아보기 위하여 각 호수에서 10 곳을 선택, 1m 수심에서 산소량 (ppm) 을 측정시,", "\n",
                  "각 호수의 평균 및 표준편차는", round(mean(one), 3), "+/-", round(sd(one), 3),"ppm,",
                  round(mean(two),3),"+/-", round(sd(two),3),"ppm,",
                  round(mean(three),3),"+/-", round(sd(three),3),"ppm 이다.", "\n", 
                  "일원분산분석에 의하면 P value=", round(ano$`Pr(>F)`[1],3), "이며 검정통계량은 F=",round(ano$`F value`[1],3), "으로 \n",
                  "호수에 따라 산소 량의 평균 (ppm) 은 차이가 나는 것으로 나타난다.")
              

# ---------------------------------------------------------------------------------

one <- c(15.5, 14.3, 16.3, 13.5, 15.7, 16.4, 14.7)
two <- c(14.7, 16.3, 15.5, 15.2, 16.3, 13.5, 15.4)
three <- c(15.5, 13.2, 16.5, 15.7, 15.3, 15.2, 14.8)

(data <- data.frame(veg=c(rep(1,7), rep(2,7), rep(3,7)), price = c(one,two,three)))

pr <- lm(price~veg, data=data)
(ano <- anova(pr))

conclusion <- cat(" 도매시장 7곳에서의 3개 채소 가격을 비교할 때 각 채소 가격의 평균 및 표준편차는", "\n",
                  round(mean(one), 3), "+/-", round(sd(one), 3),
                  round(mean(two),3),"+/-", round(sd(two),3),
                  round(mean(three),3),"+/-", round(sd(three),3)," 이다.", "\n", 
                  "일원분산분석에 의하면 P value=", round(ano$`Pr(>F)`[1],3), "이며 검정통계량은 F=",round(ano$`F value`[1],3), "으로 \n",
                  "도매시장 7곳에서의 3개 채소 가격은 차이가 나지 않는 것으로 나타난다.")



# ---------------------------------------------------------------------------------

data <- data.frame (bad = 16, good = 64)
(ch <- chisq.test(c(16,64), p=c(15,85)/100) )
conclusion <- cat(" 어느 공정의 부적합품률이 15% 일 때, 사료 80개를 추출하자 16개의 불량 (",round(16/80*100, 3),"%)이 발생하였다.", "\n",
                  "검사한 결과를 가지고 Chi-square test를 한 결과 p-value =", round(ch$p.value, 3), "이며 검정통계량은 ", round(ch$statistic, 3),"으로","\n",
                  "검사결과는 주어진 평균 부적합품률을 따르는 것으로 나타난다.")

# ---------------------------------------------------------------------------------

(data1 <- data.frame (one이상 = c(23,31,13), 
                    one이하=c(21,48,23),
                    none = c(63,159,119)))
row.names(data1) <- c("반병 이상", "반병이하", "못마심")
data1
(ch <- chisq.test(data1))
conclusion <- cat(" 흡연량과 음주량 사이에 연관이 있는가를 주제로 Chi-square test를 한 결과","\n",
                  "p-value =", round(ch$p.value, 3), "이며 검정통계량은 ", round(ch$statistic, 3),"으로","\n",
                  "흡연량과 음주량 사이에는 유의미한 연관관계가 있는 것으로 나타난다.")



















